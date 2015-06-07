class App::Responsibleteacher::BanksController < ApplicationController
    layout 'app/responsibleteacher'
    before_filter :set_bank, only: [:destroy, :note]
    respond_to :js

    def index
        @banks = Bank.all
        @next_banks = Array.new
        @prev_banks = Array.new
        @banks.each do |bank|
            if bank.date > Date.today
                @next_banks.push bank
            else
                @prev_banks.push bank
            end
        end
    end

    def note
        render :partial => 'note.js.erb'
    end

    def new
        @bank = Bank.new
        render :partial => 'save.js.erb'
    end

    def create
        @bank = Bank.new(bank_params)
        if @bank.save
            @bank.notify
            flash[:success] = t('controllers.save')
            render :partial => 'success.js.erb'
        else
            render :partial => 'save.js.erb'
        end
    end

    def destroy
        @bank.destroy
        flash[:success] = t('controllers.save')
        render :partial => 'success.js.erb'
    end

    private
    def set_bank
        @bank = Bank.find params[:id]
    end

    def bank_params
        bank_params = params.require(:bank).permit(:timeline, :teachers, :date, :_type)
        timeline_id = bank_params[:timeline]
        bank_params[:timeline] = Timeline.find(timeline_id) if Timeline.exists?(timeline_id)
        teacher_ids = params[:bank][:teachers].reject!(&:empty?)
        bank_params[:teachers] = Teacher.find(teacher_ids)
        bank_params
    end

    def set_bank
        @bank = Bank.find(params[:id])
    end
end