class Api::BanksController < ApiController
    respond_to :html

    def my_logger
        @@my_logger ||= Logger.new("#{Rails.root}/log/banks.log")
    end

    def all
        status = Array.new
        Bank.all.each do |bank|
            status.push bank.serialize
        end
        render :inline => status.to_json
    end

    def new
        status = Hash.new
        begin
            b = params[:bank]
            b['date'] = Date.parse b['date']
            bank = Bank.new b.to_hash
            params[:teachers].each do |t|
                bank.teachers.push Teacher.find t
            end
            if bank.save
                bank.notify
                my_logger.info('USER '+session[:user]['user']['id'].to_s+' SAVE bank => '+bank.id.to_s)
                status[:success] = true
            else
                status[:errors] = bank.errors
            end
        rescue Exception => e
            puts e.message
            status[:errors] = [['Desculpe, ocorreram erros na tentativa.']]
        end
        render :inline => status.to_json
    end

    def find_by_timeline
        status = Hash.new
        begin
            banks = Bank.where :timeline_id => params[:timeline]
            b = banks.first
            status[:data] = b.serialize
        rescue Exception => e
            puts e.message
            status[:errors] = [['Desculpe, ocorreram erros na tentativa.']]
        end
        render :inline => status.to_json
    end

    def delete
        status = Hash.new
        begin
            banks = Bank.where :timeline_id => params[:timeline]
            b = banks.first
            if b.delete
                my_logger.info('USER '+session[:user]['user']['id'].to_s+' DELETE bank => '+bank.id.to_s)
                status[:success] = true
            else
                status[:errors] = b.errors
            end
        rescue Exception => e
            puts e.message
            status[:errors] = [['Desculpe, ocorreram erros na tentativa.']]
            status[:errors] = [[e.message]]
        end
        render :inline => status.to_json
    end

    def get
        status = Hash.new
        begin
            b = Bank.find params[:id]
            status[:data] = b.serialize
        rescue Exception => e
            status[:errors] = [['Desculpe, ocorreram erros na tentativa.']]
        end
        render :inline => status.to_json
    end

    def findByTeacher
        status = Array.new
        begin
            banks = Teacher.find(params[:teacher_id]).banks
            banks.each do |bank|
                _bank = bank.serialize
                if(BankNote.where(:teacher_id => params[:teacher_id], :bank_id => bank.id).size > 0)
                    _bank['note'] = BankNote.find_by(:teacher_id => params[:teacher_id], :bank_id => bank.id).note
                end
                status.push(_bank)
            end
        rescue Exception => e
            puts e.message
            status[:errors] = [['Desculpe, ocorreram erros na tentativa.']]
        end
        render :inline => status.to_json
    end

    def edit
        status = Hash.new
        begin
            b = Bank.find params[:id]
            bank = params[:bank]
            b.date = Date.parse bank['date']
            b.teacher_ids = params[:teachers]
            if b.save
                my_logger.info('USER '+session[:user]['user']['id'].to_s+' EDITED bank => '+bank.id.to_s)
                b.notify
                status[:success] = true
            else
                status[:errors] = b.errors
            end
        rescue Exception => e
            status[:errors] = [['Desculpe, ocorreram erros na tentativa.']]
        end
        render :inline => status.to_json
    end

    def setNote
        status = Hash.new
        begin
            bankNote = BankNote.new
            bankNote.teacher = Teacher.find params[:teacher_id]
            bankNote.bank = Bank.find params[:bank_id]
            bankNote.note = params[:note].to_f
            if bankNote.save
                status[:success] = true
            else
                status[:errors] = bankNote.errors
            end
        rescue Exception => e
            puts e.message
            status[:errors] = [['Desculpe, ocorreram erros na tentativa.']]
        end
        render :inline => status.to_json
    end
end