module ApplicationHelper
  def glyph(*names)
    content_tag :i, nil, :class => names.map{|name| "glyphicon glyphicon-#{name.to_s.gsub('_','-')}" }
  end

  def login_url
    if Rails.env.production?
      login_post_url(:protocol => 'https')
    else
      login_post_url
    end
  end
end
