class Api::StudentController < ApiController
  respond_to :html
  def all
    render :inline => Student.all.to_json
  end

  def new
    status = Hash.new

    begin
      s = params[:student]
      student = Student.new ra: s[:ra], name: s[:name]
      if student.save
        l = Login.new login: s[:login], password: s[:password], :access => 4, :entity_id => student.id
        if l.save
          status[:success] = true
        else
          student.delete
          status[:errors] = l.errors
        end
      else
        status[:errors] = student.errors
      end
    rescue
      status[:errors] = [['Ops, algo errado aconteceu!']]
    end

    render :inline => status.to_json
  end

  def edit
    status = Hash.new

    begin
      s = Student.find params[:id]
      s.name = params[:student][:name]
      if s.save
        status[:success] = true
      else
        status[:errors] = s.errors
      end
    rescue ActiveRecord::RecordNotFound => e
      status[:errors] = [['Estudante não encontrado']]
    end

    render :inline => status.to_json
  end

  def delete
    status = Hash.new

    begin
      s = Student.find params[:id]
      if s.delete
        status[:success] = true
      else
        status[:errors] = s.errors
      end
    rescue ActiveRecord::RecordNotFound => e
      status[:errors] = [['Estudante não encontrado']]
    end

    render :inline => status.to_json
  end
end