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
  
  def type_bank(bank)
    case bank._type
    when "proposta"
      "Proposta de TCC 1"
    when "tcc1"
      "Projeto de TCC 1"
    when "tcc2"
      "Monografia de TCC 2"
    end
  end
  
  def site_title(*parts)
    content_for(:title) { (parts << "TCC - TSI").join(' - ') } unless parts.empty?
  end

  def inline_svg(path)
    File.open("app/assets/images/#{path}", "rb") do |file|
      raw file.read.to_s.force_encoding("UTF-8")
    end
  end

end
