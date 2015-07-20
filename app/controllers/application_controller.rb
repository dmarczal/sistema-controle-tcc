require 'json'
class ApplicationController < ActionController::Base
  before_filter :check_login, except: [:login, :login_post]
  before_filter :check_permission, except: [:logout, :login, :login_post]
  WillPaginate.per_page = 10

  def login_post
    if Teacher.exists?(login: params[:user][:login])
      # TODO Ldap connect
      @user = Teacher.find_by(login: params[:user][:login])
      session[:resource] = 1
    elsif Student.exists?(login: params[:user][:login])
      # TODO Ldap connect
      @user = Student.find_by(login: params[:user][:login])
      session[:resource] = 0
    else
      redirect_to login_path, :flash => { :danger => t('controllers.login.user_not_found') }
    end
    p "AHSDIUASHDIUADHS"
    session[:user_id] = @user.id
    redirect_to get_redirect_path, :flash => { :success => t('controllers.login.success_login') }
  end

  def logout
    session[:user_id] = nil
    session[:resource] = nil
    redirect_to '/login'
  end

  private
  def check_login
    if !current_user
      redirect_to login_path, :flash => { :danger => t('controllers.login.sign_in') }
    end
  end

  def get_redirect_path
    @user = current_user
    if session[:resource] == 1
      return case @user.role.id
          when 1 then responsible_teacher_path
          when 2 then tcc1_path
          when 3 then teachers_path
        end
    else
      student_path
    end
  end

  def current_user
    if session[:user_id]
      return session[:resource] == 1 ? Teacher.find(session[:user_id]) : Student.find(session[:user_id])
    end
  end
end
