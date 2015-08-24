desc "This task is called by the Heroku scheduler add-on"
task :update_items_timeline => :environment do
    puts "Updating items..."
    ItemTimeline.refresh_items
    puts "done."
end