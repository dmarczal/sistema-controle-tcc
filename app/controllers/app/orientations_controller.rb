class App::OrientationsController < ApplicationController
    before_filter :set_teacher
    before_filter :check_permission
    def index
        teacher_id = @teacher.id
        timeline_ids = Timeline.joins(:teacher_timelines).where(teacher_timelines: {:teacher_id => teacher_id}).ids
        @orientations = Orientation.where(timeline_id: timeline_ids).order(date: :desc)
    end

    def edit
        teacher_id = @teacher.id
        @tccs = Timeline.joins(:teacher_timelines).where(teacher_timelines: {:teacher_id => teacher_id})
        @orientation = Orientation.find params[:id]
        if validate_edit_orientation
          redirect_to teachers_orientacoes_path, flash: {danger: ["", "Você não pode editar uma orientação de outro semestre."]}
        else
          render 'new'
        end
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
        teacher_id = @teacher.id
        @tccs = Timeline.joins(:teacher_timelines).where(teacher_timelines: {:teacher_id => teacher_id})
    end

    def create
        orientationHash = {
            timeline: Timeline.find(params[:tcc]),
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

    private
    def set_teacher
        # enquanto não tem o login
        @teacher = current_user
    end

    def check_permission
        if (!can? :manage, :responsible) && (!can? :manage, :teacher)
          redirect_to get_redirect_path, :flash => { :danger => t('controllers.login.forbidden') }
        end
    end

    def validate_edit_orientation
      current_half = Date.today.month < 6 ? 1 : 2
      orientation_half = @orientation.date.month < 6 ? 1 : 2
      Time.now.year > @orientation.date.year || current_half < orientation_half
    end
end
