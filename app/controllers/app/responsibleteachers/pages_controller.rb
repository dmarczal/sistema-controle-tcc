class App::Responsibleteachers::PagesController < App::Responsibleteachers::BaseController
  layout 'app/responsibleteachers'
  before_filter :set_page, only: [:edit, :update, :destroy]

  def new
    @page = Page.new
    render :form
  end

  def index
    @pages = Page.all
  end

  def create
    @page = Page.new page_params
    if @page.save
      redirect_to responsible_teacher_pages_path, flash: {success: t('controllers.save')}
    else
      render :form
    end
  end

  def edit
    render :form
  end

  def update
    if @page.update_attributes page_params
      redirect_to responsible_teacher_pages_path, flash: {success: t('controllers.save')}
    else
      render :form
    end
  end

  def destroy
    redirect_to responsible_teacher_pages_path, flash: {success: t('controllers.destroy')} if @page.destroy
  end

  private
  def set_page
    @page = Page.friendly.find(params[:id])
  end

  def page_params
    params.require(:page).permit(:title, :body)
  end
end