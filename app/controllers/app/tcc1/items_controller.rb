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
    status = StatusItem.find_by(name: "Pendente")
    @items = ItemTimeline.where(status_item_id: status.id, timeline_id: timeline_ids)
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