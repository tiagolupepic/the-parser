workers 4
threads_count = 4
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
environment ENV['RACK_ENV'] || 'development'

bind "tcp://0.0.0.0:3000"

preload_app!

on_worker_boot do
end
