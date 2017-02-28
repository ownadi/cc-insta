bind "tcp://#{ENV['BIND_ON']}"

threads_count = ENV.fetch('RAILS_MAX_THREADS') { 5 }.to_i
threads threads_count, threads_count
workers ENV.fetch('WEB_CONCURRENCY') { 2 }

worker_timeout 30

restart_command 'puma'

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code before
# forking the application. This takes advantage of Copy On Write process
# behavior so workers use less memory. If you use this option you need to make
# sure to reconnect any threads in the `on_worker_boot` block.
# preload_app!

#  on_worker_boot do
# Since you'll likely use > 1 worker in production, we'll need to configure
# Puma to do a few things when a worker boots.

# We need to connect to the database. Pooling is handled automatically since
# we'll set the connection pool value in the DATABASE_URL later.
#    defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
#  end
