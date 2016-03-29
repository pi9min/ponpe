@app_path = File.expand_path('../../', __FILE__)

worker_processes 3
working_directory @app_path
preload_app true
timeout 30
listen "/tmp/unicorn_ponpe.sock", :backlog => 64
pid "/tmp/unicorn_ponpe.pid"
stderr_path File.expand_path('log/unicorn_ponpe.stderr.log', @app_path)
stdout_path File.expand_path('log/unicorn_ponpe.stdout.log', @app_path)

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
  old_pid = "#{server.config[:pid]}.oldbin"

  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
  sleep 1
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
