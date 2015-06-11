class App::Teachers::BanksController < ApplicationController
  layout 'app/teachers'
  before_filter :set_teacher
  def index
    @next_banks = Bank.next_banks.joins(:banks_teachers).where(banks_teachers: {teacher_id: @teacher.id})
    @prev_banks = Bank.prev_banks.joins(:banks_teachers).where(banks_teachers: {teacher_id: @teacher.id}).paginate(:page => params[:page]).order('created_at DESC')
  end

  private
  def set_teacher
    # enquanto não tem login
    @teacher = Teacher.first
  end
end