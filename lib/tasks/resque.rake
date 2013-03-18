task "resque:setup" => :environment

begin
  require 'resque/tasks'
  namespace :resque do
    desc "Start resque processes"
    task :start do
      %x{"/sbin/start-stop-daemon -S -b -m -p tmp/pids/resqued.pid -d #{ File.dirname(__FILE__) } -a `which bundle` -- exec rake resque:work QUEUE='*' RAILS_ENV=#{rails_env}"}
    end
  
    desc "Stop resque processes"
    task :stop do
      %x{"if [ -f tmp/pids/resqued.pid ]; then cat tmp/pids/resqued.pid | xargs kill && rm tmp/pids/resqued.pid; fi"}
    end
  
    desc "Restart resque processes"
    task :restart do
      stop
      start
    end
  end
rescue LoadError
  # puts '1 group not shown here due to the following error: Resque gem not loaded. Uncomment "gem \'resque\'" in your Gemfile.'
end