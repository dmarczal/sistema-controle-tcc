class App::Responsibleteacher::ApprovalsController < ApplicationController
  def new
    timeline = Bank.find(params[:id]).timeline
    @approval = Approval.new timeline: timeline
    render :partial => 'save.js.erb'
  end

  def create
    @approval = Approval.new approval_params
    process_file(approval_params[:file])
    if @approval.save
      flash[:success] = t('controllers.save')
      redirect_to responsible_teacher_banks_path
    else
      render :partial => 'save.js.erb'
    end
  end

  private
  def approval_params
    approval_params = params.require(:approval).permit(:file)
    approval_params[:timeline] = Timeline.find(params[:approval][:timeline_id]) if Timeline.exists?(params[:approval][:timeline_id])
    approval_params[:type_approval] = TypeApproval.find(params[:approval][:type_approval_id]) if TypeApproval.exists?(params[:approval][:type_approval_id])
    approval_params
  end

  def process_file(file)
    if file
      if file.content_type != 'image/jpeg' && file.content_type != 'application/pdf'
        @approval.file = nil
      else
        name = "approval-"+Time.now.to_s+"-"+file.original_filename
        directory = "public/uploads"
        path = File.join(directory, name)
        File.open(path, "wb") { |f| f.write(file.read) }
        @approval.file = 'uploads/'+name
      end
    end
  end
end