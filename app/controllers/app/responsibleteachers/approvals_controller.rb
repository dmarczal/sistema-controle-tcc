class App::Responsibleteachers::ApprovalsController < App::Responsibleteachers::BaseController
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
    if @approval.save
      expire_caches
      flash[:success] = t('controllers.save')
    else
      flash[:danger] = 'Ops, algum erro ocorreu. Verifique a extensão do arquivo, são aceitas extensões .jpg e .pdf.'
    end
    redirect_to responsible_teacher_banks_path
  end

  def update
    @approval.attributes = approval_params
    if @approval.save
      expire_caches
      flash[:success] = t('controllers.save')
    else
      flash[:danger] = 'Ops, algum erro ocorreu. Verifique a extensão do arquivo, são aceitas extensões .jpg e .pdf.'
    end
    redirect_to responsible_teacher_banks_path
  end

  private
  def expire_caches 
    if @approval.bank.tcc1?
      expire_fragment 'approved_proposals_tcc_one'
      expire_fragment 'approved_projects_tcc_one'
    else
      expire_fragment 'approveds_tccs'
    end
  end

  def set_approval
    @approval = Approval.find(params[:id])
  end

  def approval_params
    params.require(:approval).permit(:bank_id, :type_approval_id, :file, :complementary_file)
  end
end
