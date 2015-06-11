class App::Responsibleteachers::StudentsController < ApplicationController
    layout '/app/responsibleteacher'
    before_action :set_student, only: [:show, :edit, :update, :destroy]
    def index
        @students = Student.search(params[:search]).paginate(:page => params[:page]).order('created_at DESC')
    end

    def create
        @student = Student.new(student_params)
        if @student.save
            flash[:success] = t('controllers.save')
            redirect_to responsible_teacher_students_path
        else
            render :new
        end
    end

    def new
        @student = Student.new
    end

    def edit
    end

    def show
    end

    def update
        if @student.update student_params
            flash[:success] = t('controllers.save')
            redirect_to responsible_teacher_students_path
        else
            render :new
        end
    end

    def destroy
        @student.destroy
        flash[:success] = t('controllers.destroy')
        redirect_to responsible_teacher_students_url
    end

    private
    def student_params
        params.require(:student).permit(:name, :ra, :email, :login)
    end

    def set_student
        @student = Student.find(params[:id])
    end
end
