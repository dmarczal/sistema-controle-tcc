class App::Teachers::BanksController < App::Teachers::BaseController
  layout 'app/teachers'
  def index
    @next_banks = Bank.next_banks.joins(:banks_teachers).where(banks_teachers: {teacher_id: @teacher.id})
    @prev_banks = Bank.prev_banks.joins(:banks_teachers).where(banks_teachers: {teacher_id: @teacher.id}).paginate(:page => params[:page]).order('created_at DESC')
  end
end