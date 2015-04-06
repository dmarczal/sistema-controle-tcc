class Api::BanksController < ApiController
    respond_to :html
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
                # notificar professores e aluno da banca
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

    def edit
        status = Hash.new
        begin
            b = Bank.find params[:id]
            bank = params[:bank]
            b.date = Date.parse bank['date']
            b.teacher_ids = params[:teachers]
            if b.save
                # notificar professores e aluno da banca
                status[:success] = true
            else
                status[:errors] = b.errors
            end
        rescue Exception => e
            status[:errors] = [['Desculpe, ocorreram erros na tentativa.']]
        end
        render :inline => status.to_json
    end
end