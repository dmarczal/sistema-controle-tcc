class Api::PageController < ApiController
  respond_to :html

  def my_logger
    @@my_logger ||= Logger.new("#{Rails.root}/log/student.log")
  end

  def messages
    msgs = Hash.new
    if session.has_key?(:error)
      msgs = [['error', session[:error]]]
      session.delete :error
    elsif session.has_key?(:success)
      msgs = [['success', session[:success]]]
      session.delete :success
    elsif session.has_key?(:warning)
      msgs = [['warning', session[:warning]]]
      session.delete :warning
    elsif session.has_key?(:notice)
      msgs = [['notice', session[:notice]]]
      session.delete :notice
    end
    render :inline => msgs.to_json
  end

  def login
    login = Login.where(:login => params[:login], :password => params[:password]).first
    status = Hash.new
    if login
      session[:user] = login.getData
      status[:success] = session[:user]
    else
      status[:errors] = ['As informações não coincidem, por favor tente novamente.']
    end
    render :inline => status.to_json
  end
end