class App::Responsibleteacher::ApprovalsController < ApplicationController
  respond_to :js
  before_filter :set_approval, only: [:edit, :update]

  def new
    @approval = Approval.new bank: Bank.find(params[:id])
    render :partial => 'save.js.erb'
  end

  def edit
    render :partial => 'save.js.erb'
  end

  def create
    @approval = Approval.new approval_params
    @approval.file = process_file
    if @approval.save
      flash[:success] = t('controllers.save')
    else
      flash[:danger] = 'Ops, algum erro ocorreu. Verifique a extensão do arquivo, são aceitas extensões .jpg e .pdf.'
    end
    redirect_to responsible_teacher_banks_path
  end

  def update
    @approval.attributes = approval_params
    @approval.file = process_file
    if @approval.save
      flash[:success] = t('controllers.save')
    else
      flash[:danger] = 'Ops, algum erro ocorreu. Verifique a extensão do arquivo, são aceitas extensões .jpg e .pdf.'
    end
    redirect_to responsible_teacher_banks_path
  end

  private
  def set_approval
    @approval = Approval.find(params[:id])
  end

  def approval_params
    params.require(:approval).permit(:bank_id, :type_approval_id)
  end

  def process_file
    file = params[:approval][:file]
    if file.content_type != 'image/jpeg' && file.content_type != 'application/pdf'
      nil
    else
      name = "approval-"+Time.now.to_s+"-"+file.original_filename
      directory = "public/uploads"
      path = File.join(directory, name)
      File.open(path, "wb") { |f| f.write(file.read) }
      file = 'uploads/'+name
    end
  end
end