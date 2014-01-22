namespace :spec do
  desc "run all specs except services"
  task :most  do
    system 'rspec spec/models'
    system 'rspec spec/features'
    system 'rspec spec/controllers'
  end

  desc "run all services specs"
  task :services do
    system 'rspec spec/services'
  end
end
