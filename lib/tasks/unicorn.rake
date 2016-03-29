namespace :unicorn do
  desc "Start unicorn server"
  task :start => :environment do
    config = Rails.root.join('config', 'unicorn.rb')
    sh "bundle exec unicorn -c #{config} -E #{Rails.env} -D"
  end

  desc "Stop unicorn server"
  task :stop => :environment do
    unicorn_signal :QUIT
  end

  desc "Restart unicorn server(USR2)"
  task :restart => :environment do
    unicorn_signal :USR2
  end

  def unicorn_signal signal
    Process.kill signal, unicorn_pid
  end

  def unicorn_pid
    begin
      File.read('/tmp/unicorn_ponpe.pid').to_i
    rescue Errno::ENOENT
      raise "Unicorn doesn't seem to be runnning"
    end
  end
end
