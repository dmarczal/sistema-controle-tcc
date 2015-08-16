class FilesController < ActionController::Base
   def get
    item_timeline = ItemTimeline.find(params[:id])
    download_file(item_timeline)
    send_file("#{Rails.root}/public/#{item_timeline.file_file_name}",
              filename: item_timeline.file_file_name,
              type: item_timeline.file_content_type,
              stream: true,
              disposition: 'inline')
  end

  private
  def download_file(file)
    File.open("#{Rails.root}/public/#{file.file_file_name}",'wb') do |f|
      f.write HTTParty.get(file.file.url).parsed_response
    end
  end
end
