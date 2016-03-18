namespace :cache do
  desc "Clear all cache"
  task clear: :environment do
     Rails.cache.clear 
  end
end
