rails_env = ENV['RAILS_ENV'] || 'development'

threads 4,4

bind "unix:///home/gschool/milehigh/tmp/puma/milehigh-puma.sock"
pidfile "/home/gschool/milehigh/tmp/puma/pid"
pidfile "/home/gschool/milehigh/tmp/puma/state"

activate_control_app