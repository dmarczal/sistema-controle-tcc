require "google/api_client"
require "google_drive"
class App::StudentsController < ApplicationController
  before_filter :set_student
  before_filter :check_permission

  def timelines
    if @student.timeline.size > 0
      @timelines = Array.new
      @student.timeline.each do |timeline|
        _timeline = Hash.new
        calendar = timeline.base_timeline

        _timeline[:items] = Array.new
        timeline.item_timelines.each do |item_timeline|
          _item = item_timeline.item_base_timeline.attributes
          _item['status'] = !item_timeline.status_item.nil? ? item_timeline.status_item.name.downcase : 'none'
          _timeline[:items].push(_item)
        end

        _timeline[:calendar] = calendar.attributes
        _timeline[:json] = calendar.json
        _timeline[:calendar].delete('json')
        _timeline[:id] = timeline.id
        @timelines.push(_timeline)
      end
    end
  end

  def item
    @timeline = Timeline.find(params[:timeline_id])
    @item_base = ItemBaseTimeline.find(params[:id])
    if(DateTime.now > @item_base.date)
      flash[:warning] = t('controllers.expired_delivery_date')
      redirect_to student_path
    end
    @item_timeline = @timeline.item_timelines.find_by(item_base_timeline_id: @item_base.id)
  end

  def delivery
    @item_timeline = ItemTimeline.find(params[:id])
    file = process_file

    if file
      @item_timeline.file = file
      @item_timeline.status_item = StatusItem.find_by(name: "Pendente")
      @item_timeline.save
      flash[:success] = t('controllers.save')
      redirect_to student_path
    else
      flash[:danger] = 'Ops, algum erro ocorreu. Verifique a extensão do arquivo, são aceitas extensões .jpg e .pdf.'
      redirect_to student_delivery_item_get_path(@item_timeline.timeline_id, @item_timeline.item_base_timeline.id)
    end
  end

  private
  def check_permission
    if !(can? :manage, :student)
      redirect_to get_redirect_path, :flash => { :danger => t('controllers.login.forbidden') }
    end
  end

  def set_student
    @student = Student.first
  end

  def process_file
    file = params[:item][:file]
    if file.content_type != 'image/jpeg' && file.content_type != 'application/pdf'
      nil
    else
      ## IMPLEMENTS GOOGLE DRIVE FOR SAVE FILE IN PRODUCTION
      # client = Google::APIClient.new
      # auth = client.authorization
      # auth.client_id = "506774844262-iunr923celv43sjlu9a1j21cp570rse1.apps.googleusercontent.com"
      # auth.client_secret = "OK6Jz2kHYbqedKk5od-3JLEd"
      # print("1. Open this page:\n%s\n\n" % auth.authorization_uri)
      # print("2. Enter the authorization code shown in the page: ")
      # auth.code = $stdin.gets.chomp
      # auth.fetch_access_token!
      # access_token = auth.access_token
      # session = GoogleDrive.login_with_oauth(access_token)
      # session.upload_from_string(file.read, "item-"+Time.now.to_s+"-"+file.original_filename)
      name = "item-"+Time.now.to_s+"-"+file.original_filename
      directory = "public/uploads"
      path = File.join(directory, name)
      File.open(path, "wb") { |f| f.write(file.read) }
      file = '/uploads/'+name
    end
  end
end