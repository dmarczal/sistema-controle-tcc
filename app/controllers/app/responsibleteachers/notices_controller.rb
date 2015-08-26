class App::Responsibleteachers::NoticesController < App::Responsibleteachers::BaseController
  layout 'app/responsibleteachers'
  before_filter :set_notice, only: [:edit, :update, :destroy]

  def new
    @notice = Notice.new
    render :form
  end

  def index
    @notices = Notice.all
  end

  def create
    @notice = Notice.new notice_params
    if @notice.save
      redirect_to responsible_teacher_notices_path, flash: {success: t('controllers.save')}
    else
      render :form
    end
  end

  def edit
    render :form
  end

  def update
    if @notice.update_attributes notice_params
      redirect_to responsible_teacher_notices_path, flash: {success: t('controllers.save')}
    else
      render :form
    end
  end

  def destroy
    redirect_to responsible_teacher_notices_path, flash: {success: t('controllers.destroy')} if @notice.destroy
  end

  private
  def set_notice
    @notice = Notice.friendly.find(params[:id])
  end

  def notice_params
    params.require(:notice).permit(:title, :body)
  end
end