class Api::PageController < ApiController
  respond_to :html
  def messages
    msgs = flash
    flash.discard
    render :inline => msgs.to_json
  end

  def login
    login = Login.where(:login => params[:login], :password => params[:password]).first
    status = Hash.new
    if login
      session[:user] = login.getData
      status[:success] = [[session[:user][:homeUrl]]]
    else
      status[:errors] = ['As informações não coincidem, por favor tente novamente.']
    end
    render :inline => status.to_json
  end
end