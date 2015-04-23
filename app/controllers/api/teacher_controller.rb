class Api::TeacherController < ApiController
  respond_to :html
  def all
    render :inline => Teacher.all.to_json
  end

  def new
    status = Hash.new

    begin
      t = params[:teacher]
      teacher = Teacher.new name: t[:name], access: t[:access], lattes: t[:lattes], atuacao: t[:atuacao], email: t[:email]

      if teacher.save
        access = case teacher.access
                      when 'responsible' then 1
                      when 'tcc1' then 2
                      when 'teacher' then 3
                    end
        l = Login.new login: t[:login], password: t[:password], :access => access, :entity_id => teacher.id
        if l.save
          UsersMailer.newUser(teacher).deliver_now
          status[:success] = true
        else
          teacher.delete
          status[:errors] = l.errors
        end
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
      beforeAccess = case t.access
                      when 'responsible' then 1
                      when 'tcc1' then 2
                      when 'teacher' then 3
                    end
      t.name = params[:teacher][:name]
      t.access = params[:teacher][:access]
      t.lattes = params[:teacher][:lattes]
      t.atuacao = params[:teacher][:atuacao]
      t.email = params[:teacher][:email]

      if t.save
        access = case t.access
                      when 'responsible' then 1
                      when 'tcc1' then 2
                      when 'teacher' then 3
                    end
        login = Login.find_by(:entity_id => t.id, :access => beforeAccess)
        login.access = access
        if login.save
          status[:success] = true
        else
          status[:errors] = login.errors
        end
      else
        status[:errors] = t.errors
      end
    rescue ActiveRecord::RecordNotFound => e
      puts "ERROR: "+e.message
      status[:errors] = [['Ops, algum erro ocorreu!']]
    end

    render :inline => status.to_json
  end

  def delete
    status = Hash.new

    begin
      t = Teacher.find params[:id]
      if t.delete
        status[:success] = true
        if Login.exists? :entity_id => params[:id]
          Login.destroy_all :entity_id => params[:id]
        end
      else
        status[:errors] = t.errors
      end
    rescue ActiveRecord::RecordNotFound => e
      status[:errors] = [['Professor não encontrado']]
    end

    render :inline => status.to_json
  end

  def getPendingDocuments
    status = Hash.new
    begin
      teacher = Teacher.find params[:id]
      status = Array.new
      timelines = teacher.timeline
      timelines.each do |timeline|
        student = timeline.student
        _items = timeline.item_timelines.where :status => 'pending'
        _items.each do |item|
          base_item = item.item_base_timeline
          item = item.to_json
          item = JSON.parse item
          item['name'] = student.name
          item['title'] = base_item.title
          status.push item
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      status[:errors] = [['Professor não encontrado']]
    end

    render :inline => status.to_json
  end

  def approveDocument
    status = Hash.new
    begin
      item = ItemTimeline.find params[:id]
      item.status = "success"
      item.save
      status[:success] = true
      itemBase = item.item_base_timeline
      UsersMailer.approveRepproveItem(item.timeline.student, itemBase, item).deliver_now
      # save log
    rescue ActiveRecord::RecordNotFound => e
      status[:errors] = [['Item não encontrado']]
    rescue Exception => e
      status[:errors] = [[e.message]]
    end
    render :inline => status.to_json
  end

  def reproveDocument
    status = Hash.new
    begin
      item = ItemTimeline.find params[:id]
      item.status = "repproved"
      item.file = nil
      item.save
      status[:success] = true
      UsersMailer.approveRepproveItem(item.timeline.student, itemBase, item).deliver_now
      # save log
    rescue ActiveRecord::RecordNotFound => e
      status[:errors] = [['Item não encontrado']]
    rescue Exception => e
      status[:errors] = [[e.message]]
    end
    render :inline => status.to_json
  end

  def editProfile
    begin
      teacher = Teacher.find params[:id]
      teacher.email = params[:email]
      login = Login.where('entity_id = ? AND (access = 1 OR access = 2 OR access = 3)', params[:id]).first
      login.password = params[:password]
      if teacher.save
        if login.save
          session[:user] = login.getData
          flash[:success] = ['', "Dados alterados com sucesso."]
        else
          flash[:danger] = login.errors.first
        end
      else
        flash[:danger] = teacher.errors.first
      end
    rescue Exception => e
      flash[:danger] = ['', e.message]
    end

    controller = login.access == 1 ? 'responsavel' : 'professor'
    redirect_to '/'+controller+'/perfil'
  end
end