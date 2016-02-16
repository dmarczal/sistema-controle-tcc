class SiteController < ActionController::Base
  before_action :set_menu_pages
  caches_page :in_progress, :approveds

  def home
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    @page = Page.find_by title: "O TCC"
    @notices = Notice.limit(5)
    @banks = Bank.next_banks
  end
  
  def notices
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    @notices = Notice.paginate(:page => params[:page], per_page: 10)
  end
  
  def page
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    @page = Page.friendly.find(params[:slug])
  end
  
  def teachers
    role = Role.find_by name: "Professor"
    @teachers = Teacher.where(role: role).paginate(:page => params[:page], per_page: 25)
  end
  
  def approveds
    response.headers['Cache-Control'] = 'public, max-age=300'
    @approveds = Approval.tccs
  end
  
  def in_progress
    response.headers['Cache-Control'] = 'public, max-age=300'
    @proposals = Approval.proposals
    @projects = Approval.projects
  end
  
  def activities
  end
  
  def timeline
    tcc_calendar(params[:tcc])
    @tcc_calendar = @calendar.attributes
    @tcc_json = @tcc_calendar['json']
    @tcc_calendar.delete("json")
    @tcc_items = @items
    render layout: false
  end
  
  private
  def tcc_calendar(tcc)
    @calendar = BaseTimeline.find_by calendar_params(tcc)
    unless @calendar
        @calendar = BaseTimeline.create calendar_params(tcc)
    end
    @items = @calendar.item_base_timeline.order(date: :asc)
  end
  
  def calendar_params(tcc)
    current_half = Date.today.month < 6 ? 1 : 2
    {year: Time.now.year, half: current_half, tcc: tcc}
  end
  
  def set_menu_pages
    exclude_ids = Page.where(title: ["O TCC", "Documentos do TCC"]).ids
    @other_pages = Page.where.not(id: exclude_ids)
  end
end
