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

  def valid_orientation_tcc(tcc)
    current_half = Date.today.month < 6 ? 1 : 2
    tcc_half = tcc.base_timeline.half.to_i
    !(Time.now.year >= tcc.base_timeline.year.to_i || current_half > tcc_half)
  end
end
