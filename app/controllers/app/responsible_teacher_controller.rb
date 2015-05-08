class App::ResponsibleTeacherController < ApplicationController
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
