class ItemTimeline < ActiveRecord::Base
  belongs_to :item_base_timeline
  belongs_to :timeline
  belongs_to :status_item
  has_attached_file :file, :storage => :dropbox, :dropbox_credentials => Rails.root.join("config/dropbox.yml"), :dropbox_visibility => 'public'
  validates_attachment :file, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif", "application/pdf"] }

  def self.refreshItems
    ItemTimeline.where.not(:status => 'pending').each do |item|
      if item.item_base_timeline.date.to_time < Time.new
        item.status = StatusItem.find_by(name: "Reprovado")
        if item.save
          puts 'CRON SET STATUS: item id = '+item.id.to_s+' Status = '+item.status
        else
          puts 'ERROR IN CRON SET STATUS: item id = '+item.id.to_s
        end
      elsif  item.item_base_timeline.date.to_time < (Time.new + 1.week)
        item.status = StatusItem.find_by(name: "Entrega em breve")
        if item.save
          puts 'CRON SET STATUS: item id = '+item.id.to_s+' Status = '+item.status
        else
          puts 'ERROR IN CRON SET STATUS: item id = '+item.id.to_s
        end
      end
    end
  end

  def notify
    UsersMailer.approveRepproveItem(self.timeline.student, self.item_base_timeline, self).deliver_now
  end
end
