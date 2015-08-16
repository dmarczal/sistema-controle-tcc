class App::StudentsController < ApplicationController
  before_filter :set_student
  before_filter :check_permission

  def timelines
    if @student.timeline.size > 0
      @timelines = Array.new
      @student.timeline.each do |timeline|
        _timeline = Hash.new
        calendar = timeline.base_timeline

        _timeline[:items] = Array.new
        timeline.item_timelines.each do |item_timeline|
          _item = item_timeline.item_base_timeline.attributes
          _item['status'] = !item_timeline.status_item.nil? ? item_timeline.status_item.name.downcase : 'none'
          _timeline[:items].push(_item)
        end

        _timeline[:calendar] = calendar.attributes
        _timeline[:json] = calendar.json
        _timeline[:calendar].delete('json')
        _timeline[:id] = timeline.id
        @timelines.push(_timeline)
      end
    end
  end

  def item
    @timeline = Timeline.find(params[:timeline_id])
    @item_base = ItemBaseTimeline.find(params[:id])
    if(DateTime.now > @item_base.date)
      flash[:warning] = t('controllers.expired_delivery_date')
      redirect_to student_path
    end
    @item_timeline = @timeline.item_timelines.find_by(item_base_timeline_id: @item_base.id)
  end

  def delivery
    @item_timeline = ItemTimeline.find(params[:id])
    # @item_timeline.file = params[:item][:file]
    @item_timeline.dropbox_file = params[:item][:dropbox_file]
    @item_timeline.status_item = StatusItem.find_by(name: "Pendente")
    if @item_timeline.save
      flash[:success] = t('controllers.save')
      redirect_to student_path
    else
      flash[:danger] = 'Ops, algum erro ocorreu. Verifique a extensão do arquivo, são aceitas extensões .jpg e .pdf.'
      redirect_to student_delivery_item_get_path(@item_timeline.timeline_id, @item_timeline.item_base_timeline.id)
    end
  end

  private
  def check_permission
    if !(can? :manage, :student)
      redirect_to get_redirect_path, :flash => { :danger => t('controllers.login.forbidden') }
    end
  end

  def set_student
    @student = current_user
  end
end