class Api::StudentController < ApiController
  respond_to :html
  def all
    render :inline => Student.all.to_json
  end

  def new
    s = params[:student]
    student = Student.new ra: s[:ra], name: s[:name]

    status = Hash.new
    if student.save
      status[:success] = true
    else
      status[:errors] = student.errors
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