root = "/home/gschool/milehigh"
working_directory root
pid "#{root}/tmp/pids/puma.pid"
stderr_path "#{root}/log/puma.log"
stdout_path "#{root}/log/puma.log"

listen "/tmp/puma.blog.sock"
worker_processes 2
timeout 30