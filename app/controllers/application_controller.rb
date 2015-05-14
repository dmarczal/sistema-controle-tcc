require 'json'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action :check_login
  WillPaginate.per_page = 10

  def check_login
    if !session.has_key?(:user) && params[:action] != 'login'
        flash[:danger] = 'Por favor realize o login abaixo.'
        redirect_to '/login'
    elsif session.has_key?(:user)
        user = session[:user].to_hash
        user = user['user']
        if user && params[:action] == 'login'
            redirect_to session[:user]['homeUrl']
        else
            if params[:controller] == 'app/responsible_teacher' && user['access'] != 'responsible' || params[:controller] == 'app/tcc1' && user['access'] != 'tcc1' || params[:controller] == 'app/teacher' && user['access'] != 'teacher' || params[:controller] == 'app/student' && user['access'] != 'student'
              flash[:danger] = 'Você não tem permissão para acessar esta página, contate o administrador.'
              redirect_to '/login'
            end
        end
    end
  end

  def logout
    session[:user] = nil
    redirect_to '/login'
  end
end
