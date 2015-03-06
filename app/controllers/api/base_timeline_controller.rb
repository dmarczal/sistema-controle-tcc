class Api::BaseTimelineController < ApiController
  def getBase
    status = Hash.new
    if(params[:id])
      if BaseTimeline.exists?(:id => params[:id])
        base = BaseTimeline.find(params[:id])
        items = base.item_base_timeline
        base = base.attributes
        items.each do |item|
          item[:date] = item[:date].strftime '%d/%m/%Y'
        end
        base['items'] = items
        status[:data] = base
      else
        status[:errors] = [['Erro ao encontrar base.']]
      end
    else
      all = Array.new
      BaseTimeline.all.each do |base|
        items = base.item_base_timeline
        base = base.attributes
        base['items'] = items
        all.push base
      end
      status[:data] = all
    end
    render :inline => status.to_json
  end

  def searchBase
    status = Hash.new
    base = BaseTimeline.find_by(:year => params[:year], :half => params[:half], :tcc => params[:tcc])
    if base
      items = base.item_base_timeline
      items.each do |item|
        item[:date] = item[:date].strftime '%d/%m/%Y'
      end
      base = base.attributes
      base['items'] = items
      status[:data] = base
    else
      status[:errors] = [['Erro ao encontrar base.']]
    end
    render :inline => status.to_json
  end

  def editBase
    status = Hash.new
    if BaseTimeline.exists?(:id => params[:base]['id'])
      base = BaseTimeline.find(params[:base]['id'])
      new_base = params[:base]

      base.year = new_base['year']
      base.half = new_base['half']
      base.tcc = new_base['tcc']
      base.json = new_base['json'] ? new_base['json'] : ''

      if new_base['items']
        if base.item_base_timeline.ids.length > new_base['items'].length
          old_ids = base.item_base_timeline.ids
          new_ids = Array.new
          new_base['items'].each { |item| new_ids.push(item['id'])}
          delete_ids = old_ids - new_ids
          base.item_base_timeline.where(:id => delete_ids).destroy_all
        end
        new_base['items'].each do |new_item|
          if base.item_base_timeline.exists?(new_item['id'])
            item = base.item_base_timeline.find(new_item['id'])
            item.description = new_item['description']
            item.link = new_item['link']
            item.title = new_item['title']
            item._type = new_item['_type']
            new_item['date'] = Date.strptime(new_item['date'], '%d-%m-%Y')
            item.date = new_item['date']
            unless item.save
              status[:errors] = item.errors
              break
            end
          else
            unless new_item['date'] =~ /^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]|(?:Jan|Mar|May|Jul|Aug|Oct|Dec)))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2]|(?:Jan|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec))\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)(?:0?2|(?:Feb))\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9]|(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep))|(?:1[0-2]|(?:Oct|Nov|Dec)))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$/
              status[:errors] = [['Especifique uma data válida.']]
              break
            end
            new_item['date'] = Date.strptime(new_item['date'], '%d-%m-%Y')
            item_timeline = ItemBaseTimeline.new :description => new_item['description'], :title => new_item['title'], :_type => new_item['_type'], :date => new_item['date'], :link => new_item['link']
            unless item_timeline.save
              status[:errors] = item_timeline.errors
              break
            else
              base.item_base_timeline.push item_timeline
            end
          end
        end
      else
        base.item_base_timeline.delete_all
      end

      if base.save
        status[:success] = true
      else
        status[:errors] = base.errors
      end
    else
      status[:errors] = [['Erro ao encontrar base.']]
    end
    render :inline => status.to_json
  end

  def deleteBase
    status = Hash.new
    if BaseTimeline.exists?(:id => params[:id])
      if BaseTimeline.delete(params[:id])
        status[:success] = [['Base excluída com sucesso.']]
      else
        status[:errors] = [['Erro ao encontrar base.']]
      end
    else
      status[:errors] = [['Erro ao encontrar base.']]
    end
    render :inline => status.to_json
  end

  def newBase
    base_param = params[:base]
    items_timeline = base_param['items']
    base = BaseTimeline.new :year => base_param['year'], :half => base_param['half'], :tcc => base_param['tcc'], :json => base_param['json'] ? base_param['json'] : ''

    response = Hash.new
    response[:errors] = []

    items_timeline.each do |item|
      date = item['date'].split '-'
      item['date'] = Date.strptime(item['date'], '%d-%m-%Y')
      item_timeline = ItemBaseTimeline.new :description => item['description'], :title => item['title'], :_type => item['_type'], :date => item['date'], :link => item['link']
      if item_timeline.save
        base.item_base_timeline.push item_timeline
      else
        response[:errors].push item_timeline.errors
      end
    end

    if response[:errors].length == 0
      if base.save
        response[:success] = true
      else
        response[:errors] = base.errors
      end
    end
    render :inline => response.to_json
  end

  def setJson
    if params[:id]
      response = Hash.new
      base = BaseTimeline.find params[:id]
      if params[:json]
        base.json = params[:json]
        if base.save
          response[:success] = true
        else
          response[:errors] = base.errors
        end
      else
        response[:errors] = [['Envie um JSON.']]
      end
      render :inline => response.to_json
    end
  end
end
