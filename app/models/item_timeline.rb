class ItemTimeline < ActiveRecord::Base
  belongs_to :item_base_timeline
  belongs_to :timeline

  def self.refreshItems
    ItemTimeline.where.not(:status => 'pending').each do |item|
      if item.item_base_timeline.date.to_time < Time.new
        item.status = 'danger'
        if item.save
          puts 'CRON SET STATUS: item id = '+item.id.to_s+' Status = '+item.status
        else
          puts 'ERROR IN CRON SET STATUS: item id = '+item.id.to_s
        end
      elsif  item.item_base_timeline.date.to_time < (Time.new + 1.week)
        item.status = 'warning'
        if item.save
          puts 'CRON SET STATUS: item id = '+item.id.to_s+' Status = '+item.status
        else
          puts 'ERROR IN CRON SET STATUS: item id = '+item.id.to_s
        end
      end
    end
  end
end
