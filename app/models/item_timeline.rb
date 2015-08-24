class ItemTimeline < ActiveRecord::Base
  include Paperclip::Glue
  belongs_to :item_base_timeline
  belongs_to :timeline
  belongs_to :status_item

  has_attached_file(:file, {}.merge(PaperclipStorage.options))

  validates_with AttachmentSizeValidator, :attributes => :file, :less_than => 10.megabytes
  validates_with AttachmentContentTypeValidator, :attributes => :file, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif", "application/pdf"]


  def self.refresh_items
    ids = StatusItem.where(name: ["Pendente", "Nenhum"]).ids
    ItemTimeline.where(:status_item_id => ids).each do |item|
      if item.item_base_timeline.date.to_time < Time.new
        item.status_item = StatusItem.find_by(name: "Reprovado")
        if item.save
          puts 'CRON SET STATUS: item id = '+item.id.to_s+' Status = '+item.status_item.name
        else
          puts 'ERROR IN CRON SET STATUS: item id = '+item.id.to_s
        end
      elsif  item.item_base_timeline.date.to_time < (Time.new + 1.week)
        item.status_item = StatusItem.find_by(name: "Entrega em breve")
        if item.save
          puts 'CRON SET STATUS: item id = '+item.id.to_s+' Status = '+item.status_item.name
        else
          puts 'ERROR IN CRON SET STATUS: item id = '+item.id.to_s
        end
      end
    end
  end

  def notify
    UsersMailer.approveRepproveItem(self.timeline.student, self.item_base_timeline, self).deliver!
  end
end
