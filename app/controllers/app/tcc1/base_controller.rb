class App::Tcc1::BaseController < ApplicationController
  def check_permission
    if !(can? :manage, :tcc1)
      redirect_to get_redirect_path, :flash => { :danger => t('controllers.login.forbidden') }
    end
  end
end