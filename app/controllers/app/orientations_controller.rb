class App::OrientationsController < ApplicationController
    def index
        teacher_id = session[:user]['user']['id']
        @orientations = Orientation.joins(:timeline).where(:timelines => {:teacher_id => teacher_id})
    end

    def edit
        teacher_id = session[:user]['user']['id']
        @tccs = Timeline.where(:teacher_id => teacher_id)
        @orientation = Orientation.find params[:id]
        render 'new'
    end

    def editPost
        begin
            orientation = Orientation.find params[:id]
            orientationHash = {
                timeline_id: params[:tcc],
                title: params[:title],
                description: params[:description],
                date: Date.parse(params[:date])
            }
            orientation.assign_attributes(orientationHash)
            if orientation.save
                flash[:success] = ['','Orientação cadastrada com sucesso.']
                redirect_to '/professor/orientacoes'
            else
                flash[:danger] = orientation.errors.first
                redirect_to '/professor/orientacoes/new'
            end
        rescue Exception => e
            puts e.message
            flash[:danger] = ['','Ops, algum erro aconteceu!']
            redirect_to '/professor/orientacoes/'+params[:id]+'/edit'
        end
    end

    def destroy
        begin
            orientation = Orientation.find params[:id]
            if orientation.delete
                flash[:success] = ['','Orientação removida com sucesso.']
            else
                puts orientation.errors.inspect
                flash[:danger] = ['','Ops, algum erro aconteceu!']
            end
            redirect_to '/professor/orientacoes'
        rescue Exception => e
            puts e.message
            flash[:danger] = ['','Ops, algum erro aconteceu!']
            redirect_to '/professor/orientacoes'
        end
    end

    def new
        teacher_id = session[:user]['user']['id']
        @tccs = Timeline.where(:teacher_id => teacher_id)
    end

    def create
        orientationHash = {
            timeline_id: params[:tcc],
            title: params[:title],
            description: params[:description],
            date: Date.parse(params[:date])
        }
        orientation = Orientation.new orientationHash
        if orientation.save
            flash[:success] = ['','Orientação cadastrada com sucesso.']
            redirect_to '/professor/orientacoes'
        else
            flash[:danger] = orientation.errors.first
            redirect_to '/professor/orientacoes/new'
        end
    end
end
