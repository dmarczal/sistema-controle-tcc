class Api::TeacherController < ApiController
  respond_to :html
  def all
    render :inline => Teacher.all.to_json
  end

  def new
    status = Hash.new

    begin
      t = params[:teacher]
      teacher = Teacher.new name: t[:name], access: t[:access], lattes: t[:lattes], atuacao: t[:atuacao]

      if teacher.save
        status[:success] = true
      else
        status[:errors] = teacher.errors
      end
    rescue
      status[:errors] = [['Desculpe, ocorreram erros na tentativa.']]
    end

    render :inline => status.to_json
  end

  def edit
    status = Hash.new
    begin
      t = Teacher.find params[:id]
      t.name = params[:teacher][:name]
      t.access = params[:teacher][:access]
      t.lattes = params[:teacher][:lattes]
      t.atuacao = params[:teacher][:atuacao]
      if t.save
        status[:success] = true
      else
        status[:errors] = t.errors
      end
    rescue ActiveRecord::RecordNotFound => e
      status[:errors] = [['Professor não encontrado']]
    end

    render :inline => status.to_json
  end

  def delete
    status = Hash.new

    begin
      t = Teacher.find params[:id]
      if t.delete
        status[:success] = true
      else
        status[:errors] = t.errors
      end
    rescue ActiveRecord::RecordNotFound => e
      status[:errors] = [['Professor não encontrado']]
    end

    render :inline => status.to_json
  end
end