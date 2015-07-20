class App::Responsibleteachers::TeachersController < App::Responsibleteachers::BaseController
    layout '/app/responsibleteachers'
    before_action :set_teacher, only: [:show, :edit, :update, :destroy]
    def index
        @teachers = Teacher.search(params[:search]).paginate(:page => params[:page]).order('created_at DESC')
    end

    def create
        @teacher = Teacher.new teacher_params
        if @teacher.save
            flash[:success] = t('controllers.save')
            redirect_to responsible_teacher_teachers_path
        else
            render :new
        end
    end

    def new
        @teacher = Teacher.new
    end

    def edit
    end

    def show
    end

    def update
        if @teacher.update teacher_params
            flash[:success] = t('controllers.save')
            redirect_to responsible_teacher_teachers_path
        else
            render :new
        end
    end

    def destroy
        @student.destroy
        flash[:success] = t('controllers.destroy')
        redirect_to responsible_teacher_teachers_url
    end

    private
    def teacher_params
        params.require(:teacher).permit(:name, :lattes, :atuacao, :email, :login, :role_id)
    end

    def set_teacher
        @teacher = Teacher.find(params[:id])
    end
end
