require 'json'
class ApplicationController < ActionController::Base
  before_filter :check_login, except: [:login, :login_post, :logout]
  before_filter :check_permission, except: [:logout, :login, :login_post]
  before_filter :redirect_to_https
  WillPaginate.per_page = 10

  def login_post
    user = connect(params[:user])

    user = {"email" => "ericodias1@gmail.com"}

    roles = Role.where(name: ["Professor responsável", "Professor de TCC 1"]).ids
    if Teacher.exists?(login: params[:user][:login], role_id: [roles])
      user = Teacher.find_by(login: params[:user][:login])
      if user.password.check?(params[:user][:password])
        @user = user
        session[:resource] = 1
      else
        redirect_to login_path, :flash => { :danger => t('controllers.login.incorrect_password') }
      end
    elsif user
      if Teacher.exists?(login: params[:user][:login])
        @user = Teacher.find_by(login: params[:user][:login])
        @user.update! email: user["email"]
        session[:resource] = 1
      elsif Student.exists?(login: params[:user][:login])
        @user = Student.find_by(login: params[:user][:login])
        @user.update! email: user["email"]
        session[:resource] = 0
      else
        redirect_to login_path, :flash => { :danger => t('controllers.login.user_not_found') }
      end
    else
      redirect_to login_path, :flash => { :danger => t('controllers.login.authentication_error') }
    end

    if @user
      session[:user_id] = @user.id
      redirect_to get_redirect_path, :flash => { :success => t('controllers.login.success_login') }
    end
  end

  def logout
    session[:user_id] = nil
    session[:resource] = nil
    redirect_to '/login'
  end

  private
  def connect(user)
    response = RestClient.post 'http://tsi.gp.utfpr.edu.br/ldap/',
      { user: { user_name: user[:login], password: user[:password]} }.to_json,
      {
        authorization: 'Token token="6e89e720147952ced8ebf25d2977316c9a798a78"',
        content_type: :json, accept: :json
      }
    data = JSON.parse(response)
    if(data["status"] == "200")
      data["user"]
    else
      nil
    end
  end

  def redirect_to_https
    redirect_to :protocol => "https://" unless (request.ssl? || request.local?)
  end

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
