APP_ROOT = File.expand_path(File.dirname(File.dirname(File.dirname(__FILE__))))

worker_processes 3
listen APP_ROOT + '/tmp/sockets/unicorn.sock', backlog: 64
timeout 60

working_directory APP_ROOT
pid APP_ROOT + '/tmp/pids/unicorn.pid'
stderr_path '/dev/null'
stdout_path '/dev/null'

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and GC.copy_on_write_friendly = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      puts 'Old master alerady dead'
    end
  end

  sleep 1
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
  child_pid = server.config[:pid].sub('.pid', ".#{worker.nr}.pid")
  system("echo #{Process.pid} > #{child_pid}")
end
