# Flush Redis keys
namespace :db do
  namespace :drop do
    desc "Drop Redis database"
    task :redis => :environment do
      REDIS.flushdb
    end
  end
end