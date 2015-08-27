class App::Teachers::ItemsController < App::Teachers::BaseController
  layout 'app/teachers'
  before_filter :set_item, except: [:pending]
  before_filter :set_teacher, only: [:pending]
  after_filter :notify, only: [:approve, :repprove_post ]

  def show
  end

  def approve
    @item.status_item = StatusItem.find_by(name: "Aprovado")
    @item.note = nil
    @item.save
    flash[:success] = t('controllers.approve_item')
    redirect_to teachers_item_path(@item.timeline, @item.item_base_timeline)
  end

  def repprove
    render :note, formats: [:js]
  end

  def repprove_post
    @item.status_item = StatusItem.find_by(name: "Reprovado")
    @item.note = params[:note] if params[:note]
    @item.save
    flash[:success] = t('controllers.repprove_item')
    redirect_to teachers_item_path(@item.timeline, @item.item_base_timeline)
  end

  def pending
    timeline_ids = Timeline.joins(:teacher_timelines).where(teacher_timelines: {teacher_id: [@teacher.id]}).ids
    @items = ItemTimeline.where(status_item_id: [1,3,4], timeline_id: timeline_ids).paginate(:page => params[:page]).order('updated_at DESC')
  end

  private
  def set_item
    @timeline = Timeline.find(params[:timeline_id])
    @item_base = ItemBaseTimeline.find(params[:id])
    @item = ItemTimeline.find_by(timeline: @timeline, item_base_timeline: @item_base)
  end

  def set_teacher
    @teacher = current_user
  end

  def notify
    @item.notify
  end
end
