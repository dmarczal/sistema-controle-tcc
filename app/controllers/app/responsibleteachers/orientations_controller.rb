require 'will_paginate/array'
class App::Responsibleteachers::OrientationsController < App::Responsibleteachers::BaseController
  layout 'app/responsibleteachers'
  def orientations
    @tccs = Timeline.joins(:base_timeline).order("base_timelines.year").reverse.paginate(:page => params[:page])
  end

  def orientations_by_timeline
    @orientations = Orientation.joins(:timeline).where(:timelines => {:id => params[:timeline]}).order(date: :desc).paginate(:page => params[:page])
  end

  def orientation
    @orientation = Orientation.find params[:id]
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
  end
end
