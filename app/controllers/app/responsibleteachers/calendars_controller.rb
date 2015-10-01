class App::Responsibleteachers::CalendarsController < App::Responsibleteachers::BaseController
    layout 'app/responsibleteachers'
    respond_to :js
    before_action :set_item, only: [:edit, :update, :destroy]
    before_action :set_calendar, only: [:show, :timeline]

    def index
        half = Date.today.strftime("%m").to_i < 6 ? 1 : 2
        redirect_to "/responsavel/calendarios/#{Time.now.year.to_s}/#{half.to_s}/1"
    end

    def new
        @item = ItemBaseTimeline.new
        @calendar = BaseTimeline.find params[:id]
        render :partial => 'edit.js.erb'
    end

    def timeline
        @calendar = @calendar.attributes
        @json = @calendar['json']
        @calendar.delete("json")
    end

    def create
        @item = ItemBaseTimeline.new item_params
        @item.base_timeline = BaseTimeline.find params[:calendar_id]
        if @item.save
            set_item_link
            @item.save
            flash[:success] = t('controllers.save')
            @url = responsible_teacher_calendars_url+@item.base_timeline.path
            @type = 'success'
            render :partial => 'redirect.js.erb'
        else
            render :partial => 'edit.js.erb'
        end
    end

    def edit
        render :partial => 'edit.js.erb'
    end

    def update
        set_item_link
        if @item.update item_params
            flash[:success] = t('controllers.save')
            @url = responsible_teacher_calendars_url+@item.base_timeline.path
            @type = 'success'
            render :partial => 'redirect.js.erb'
        else
            render :partial => 'edit.js.erb'
        end
    end

    def destroy
        @item.destroy
        flash[:success] = 'Item excluído com sucesso.'
        @url = responsible_teacher_calendars_url+@item.base_timeline.path
        @type = 'success'
        render :partial => 'redirect.js.erb'
    end

    def save_timeline
        @calendar = BaseTimeline.find params[:id]
        @calendar.json = params[:json]
        if @calendar.save
            response = {response: true}
        else
            response = {response: @calendar.errors}
        end
        render :inline => response.to_json
    end

    private
    def calendar_params
        params.permit(:year, :half, :tcc)
    end

    def set_calendar
        @calendar = BaseTimeline.find_by calendar_params
        if !@calendar
            @calendar = BaseTimeline.create calendar_params
        end
        @items = @calendar.item_base_timeline.order(date: :asc)
    end

    def set_item_link
        link_param = params[:item_base_timeline][:link]
        if link_param.length > 0
            @item.link = link_param
        else
            @item.link = 'http://'+request.env["HTTP_HOST"]+'/academico/item/'+@item.id.to_s
        end
    end

    def item_params
       params.require(:item_base_timeline).permit(:title, :_type, :date, :description)
    end

    def set_item
        @item = ItemBaseTimeline.find_by_id params[:id]
    end
end