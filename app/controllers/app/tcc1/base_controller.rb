class App::Tcc1::BaseController < ApplicationController
  before_filter :set_teacher
  def check_permission
    if !can? :manage, :tcc1
      redirect_to get_redirect_path, :flash => { :danger => t('controllers.login.forbidden') }
    end
  end

  private
  def set_teacher
    @teacher = current_user
  end
end