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

  def editItemBase
    status = Hash.new
    item = params[:item]
    begin
      i = ItemBaseTimeline.find item['id']
      i.title = item['title']
      i._type = item['_type']
      i.date = item['date'].to_date
      i.link = item['link'] != '#' ? item['link'] : 'http://'+request.env["HTTP_HOST"]+'/academico/item#'+i.id.to_s
      puts i.link
      i.description = item['description']
      if i.save
        status[:success] = true
      else
        status[:errors] = i.errors
      end
    rescue ActiveRecord::RecordNotFound => e
      status[:errors] = [['Item de calendário não foi encontrado.']]
    rescue Exception => e
      status[:errors] = [[e.message]]
    end
    render :inline => status.to_json
  end

  def deleteItemBase
    status = Hash.new
    begin
      item = ItemBaseTimeline.find params[:id]
      if item.delete
        status[:success] = true
      else
        status[:errors] = item.errors
      end
    rescue ActiveRecord::RecordNotFound => e
      status[:errors] = [['Item não encontrado']]
    end
    render :inline => status.to_json
  end

  def newItemBase
    params[:item].delete('id')
    item = params[:item]
    base = params[:base]

    response = Hash.new
    begin
      _base = BaseTimeline.where base.to_hash
      if _base.first
        base = _base.first
      else
        base = BaseTimeline.new base.to_hash
        unless base.save
          raise base.errors
        end
      end
      i = ItemBaseTimeline.new item.to_hash
      if i.save
        i.link = i.link != '#' ? i.link : 'http://'+request.env["HTTP_HOST"]+'/academico/item#'+i.id.to_s
        puts i.link
        base.item_base_timeline.push i
        response[:success] = true
      else
        raise i.errors
      end
    rescue Exception => e
      response[:errors] = [[e.message ? e.message : 'Ops, algo aconteceu errado, tente novamente.']]
    end
    render :inline => response.to_json
  end

  def setJson
    response = Hash.new
    begin
      base = BaseTimeline.find params[:id]
      if params[:json]
        base.json = params[:json]
        puts params[:json]
        if base.save
          response[:success] = true
        else
          response[:errors] = base.errors
        end
      else
        response[:errors] = [['Envie um JSON.']]
      end
    rescue ActiveRecord::RecordNotFound => e
      response[:errors] = [['Calendário não encontrado']]
    end
    render :inline => response.to_json
  end
end
