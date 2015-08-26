class App::Tcc1::ItemsController < App::Tcc1::BaseController
  layout 'app/tcc1'
  before_filter :set_item, except: [:pending]
  after_filter :notify, only: [:approve, :repprove ]

  def show
  end

  def approve
    @item.status_item = StatusItem.find_by(name: "Aprovado")
    @item.note = nil
    @item.save
    flash[:success] = t('controllers.approve_item')
    redirect_to tcc1_item_path(@item.timeline, @item.item_base_timeline)
  end

  def repprove
    render :note, formats: [:js]
  end

  def repprove_post
    @item.status_item = StatusItem.find_by(name: "Reprovado")
    @item.note = params[:note] if params[:note]
    @item.save
    flash[:success] = t('controllers.repprove_item')
    redirect_to tcc1_item_path(@item.timeline, @item.item_base_timeline)
  end

  def pending
    timeline_ids = Timeline.joins(:base_timeline).where(base_timelines: {tcc: 1}).ids
    @items = ItemTimeline.where(status_item_id: [1,3,4], timeline_id: timeline_ids).paginate(:page => params[:page]).order('updated_at DESC')
  end

  private
  private
  def set_item
    @timeline = Timeline.find(params[:timeline_id])
    @item_base = ItemBaseTimeline.find(params[:id])
    @item = ItemTimeline.find_by(timeline: @timeline, item_base_timeline: @item_base)
  end

  def notify
    @item.notify
  end
end