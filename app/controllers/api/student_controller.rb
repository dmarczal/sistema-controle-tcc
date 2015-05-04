class Api::StudentController < ApiController
  respond_to :html

  def my_logger
    @@my_logger ||= Logger.new("#{Rails.root}/log/student.log")
  end

  def all
    render :inline => Student.all.to_json
  end

  def new
    status = Hash.new

    begin
      s = params[:student]
      student = Student.new ra: s[:ra], name: s[:name], email: s[:email]
      if student.save
        l = Login.new login: s[:login], password: s[:password], :access => 4, :entity_id => student.id
        if l.save
          my_logger.info('USER '+session[:user]['user']['id']+' SAVE new student => '+student.id.to_s+' / login => '+l.id.to_s)
          UsersMailer.newUser(student).deliver_now
          status[:success] = true
        else
          student.delete
          status[:errors] = l.errors
        end
      else
        status[:errors] = student.errors
      end
    rescue Exception => e
      puts e.message
      status[:errors] = [['Ops, algo errado aconteceu!']]
    end

    render :inline => status.to_json
  end

  def edit
    status = Hash.new

    begin
      s = Student.find params[:id]
      s.name = params[:student][:name]
      s.email = params[:student][:email]
      if s.save
        my_logger.info('USER '+session[:user]['user']['id']+' EDITED student => '+s.id.to_s)
        status[:success] = true
      else
        status[:errors] = s.errors
      end
    rescue ActiveRecord::RecordNotFound => e
      status[:errors] = [['Estudante não encontrado']]
    end

    render :inline => status.to_json
  end

  def delete
    status = Hash.new

    begin
      s = Student.find params[:id]
      if s.delete
        Timeline.where(student_id: params[:id]).destroy_all
        my_logger.info('USER '+session[:user]['user']['id']+' DELETED student => '+s.id.to_s)
        status[:success] = true
      else
        status[:errors] = s.errors
      end
    rescue ActiveRecord::RecordNotFound => e
      status[:errors] = [['Estudante não encontrado']]
    end

    render :inline => status.to_json
  end

  def editProfile
    begin
      student = Student.find params[:id]
      student.email = params[:email]
      login = Login.where('entity_id = ? AND access = 4', params[:id]).first
      login.password = params[:password]
      if student.save
        if login.save
          session[:user] = login.getData
          my_logger.info('USER '+session[:user]['user']['id']+' EDITED student profile => '+student.id.to_s)
          flash[:success] = ['', "Dados alterados com sucesso."]
        else
          flash[:danger] = login.errors.first
        end
      else
        flash[:danger] = student.errors.first
      end
    rescue Exception => e
      flash[:danger] = ['', e.message]
    end

    redirect_to '/academico/perfil'
  end
end