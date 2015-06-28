class App::StudentsController < ApplicationController
  before_filter :set_student

  def timelines
    @timelines = Array.new
    @student.timeline.each do |timeline|
      _timeline = Hash.new
      calendar = timeline.base_timeline

      _timeline[:items] = Array.new
      calendar.item_base_timeline.each do |item|
        item_timeline = ItemTimeline.find_by(timeline_id: timeline.id, item_base_timeline_id: item.id)
        _item = item.attributes
        _item['status'] = item_timeline.status_item.name.downcase
        _timeline[:items].push(_item)
      end

      _timeline[:calendar] = calendar.attributes
      _timeline[:json] = calendar.json
      _timeline[:calendar].delete('json')
      _timeline[:id] = timeline.id
      @timelines.push(_timeline)
    end
  end

  def item
    @timeline = Timeline.find(params[:timeline_id])
    @item_base = ItemBaseTimeline.find(params[:id])
    @item_timeline = @timeline.item_timelines.find_by(item_base_timeline_id: @item_base.id)
  end

  def delivery
    @item_timeline = ItemTimeline.find(params[:id])
    file = process_file

    if file
      @item_timeline.file = file
      @item_timeline.status_item = StatusItem.find_by(name: "Pendente")
      @item_timeline.save
      flash[:success] = t('controllers.save')
      redirect_to student_path
    else
      flash[:danger] = 'Ops, algum erro ocorreu. Verifique a extensão do arquivo, são aceitas extensões .jpg e .pdf.'
      redirect_to student_delivery_item_get_path(@item_timeline.timeline_id, @item_timeline.item_base_timeline.id)
    end
  end

  private
  def set_student
    @student = Student.first
  end

  def process_file
    file = params[:item][:file]
    if file.content_type != 'image/jpeg' && file.content_type != 'application/pdf'
      nil
    else
      name = "item-"+Time.now.to_s+"-"+file.original_filename
      directory = "public/uploads"
      path = File.join(directory, name)
      File.open(path, "wb") { |f| f.write(file.read) }
      file = 'uploads/'+name
    end
  end
end