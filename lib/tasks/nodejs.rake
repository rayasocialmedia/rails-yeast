namespace :nodejs do
  desc "Start Node Application"
  task :start do
    %x{"/sbin/start-stop-daemon -S -b -m -p tmp/pids/nodejsd.pid -d #{ File.dirname(__FILE__) }/node -a `which node` app.js"}
  end
  
  desc "Stop Node Application"
  task :stop do
    %x{"/sbin/start-stop-daemon -K -p tmp/pids/nodejsd.pid -d #{ File.dirname(__FILE__) }/node -a `which node` app.js"}
  end

  desc "Restart Node Application"
  task :restart do
    stop
    start
  end
end
