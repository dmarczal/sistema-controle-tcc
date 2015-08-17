class App::Responsibleteachers::OrientationsController < App::Responsibleteachers::BaseController
  layout 'app/responsibleteachers'
  def orientations
    @tccs = Timeline.all
  end

  def orientations_by_timeline
    @orientations = Orientation.joins(:timeline).where(:timelines => {:id => params[:timeline]})
  end

  def orientation
    @orientation = Orientation.find params[:id]
  end
end