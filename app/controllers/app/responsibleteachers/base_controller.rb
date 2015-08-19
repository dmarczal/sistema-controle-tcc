class App::Responsibleteachers::BaseController < ApplicationController
  def check_permission
    if !can? :manage, :responsible
      redirect_to get_redirect_path, :flash => { :danger => t('controllers.login.forbidden') }
    end
  end
end