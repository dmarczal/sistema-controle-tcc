class PasswordsController < ApplicationController
  skip_before_filter :check_permission
  before_filter :set_password

  def edit
    render :partial => "edit", formats: :js
  end

  def update
    @password.password = params[:password]
    if @password.save
      flash[:success] = "Senha alterada com sucesso."
      @type = 'success'
      @redirect = get_redirect_path
    else
      @type = 'failure'
    end
    render :partial => "redirect", formats: :js
  end

  private
  def set_password
    @password = current_user.password
  end
end
