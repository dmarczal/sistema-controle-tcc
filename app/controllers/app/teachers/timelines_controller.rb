class App::Teachers::TimelinesController < App::Teachers::BaseController
  layout '/app/teachers'
  before_filter :set_teacher
  def index
    redirect_to '/professor/timelines/'+Time.now.year.to_s+'/1/1'
  end

  def show
    timeline = Timeline.find(params[:id])
    @_calendar = timeline.base_timeline
    items = @_calendar.item_base_timeline

    @items = Array.new
    timeline.item_timelines.each do |item_timeline|
      _item = item_timeline.item_base_timeline.attributes
      _item['status'] = !item_timeline.status_item.nil? ? item_timeline.status_item.name.downcase : 'none'
      @items.push(_item)
    end

    @calendar = @_calendar.attributes
    @json = @_calendar.json
    @calendar.delete("json")
    @timeline_id = params[:id]
    render :partial => 'show.js.erb'
  end

  def list
    @timelines = Timeline.joins(:base_timeline).joins(:teacher_timelines).where(base_timelines: {year: params[:year], half: params[:half], tcc: params[:tcc]}, teacher_timelines: {teacher_id: [@teacher.id]})
  end

  private
  def set_teacher
    # set logged teacher
    @teacher = Teacher.first
  end
end