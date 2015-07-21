class App::Tcc1::ItemsController < App::Tcc1::BaseController
  layout 'app/tcc1'
  before_filter :set_item, except: [:pending]
  before_filter :set_teacher, only: [:pending]
  before_filter :notify, only: [:approve, :repprove ]

  def show
  end

  def approve
    @item.status_item = StatusItem.find_by(name: "Aprovado")
    @item.save
    flash[:success] = t('controllers.approve_item')
    redirect_to tcc1_item_path(@item.timeline, @item)
  end

  def repprove
    @item.status_item = StatusItem.find_by(name: "Reprovado")
    @item.save
    flash[:success] = t('controllers.repprove_item')
    redirect_to tcc1_item_path(@item.timeline, @item)
  end

  def pending
    timeline_ids = Timeline.joins(:base_timeline).where(base_timelines: {tcc: 1}).ids
    @items = ItemTimeline.where(status_item_id: [1,3,4], timeline_id: timeline_ids).paginate(:page => params[:page]).order('updated_at DESC')
  end

  private
  def set_item
    @item = ItemTimeline.find(params[:id])
  end

  def set_teacher
    # enquanto não tem login
    @teacher = Teacher.first
  end

  def notify
    @item.notify
  end
end