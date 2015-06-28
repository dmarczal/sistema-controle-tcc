class App::Teachers::TimelinesController < ApplicationController
  layout '/app/teachers'
  before_filter :set_teacher
  def index
    redirect_to '/professor/timelines/'+Time.now.year.to_s+'/1/1'
  end

  def show
    @_calendar = Timeline.find(params[:id]).base_timeline
    items = @_calendar.item_base_timeline

    @items = Array.new
    items.each do |item|
      item_timeline = ItemTimeline.find_by(timeline_id: params[:id], item_base_timeline_id: item.id)
      _item = item.attributes
      _item['status'] = item_timeline.status_item.name.downcase
      @items.push _item
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