# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'
# load sneakers tasks
require 'sneakers/tasks'

Rails.application.load_tasks
namespace :rabbitmq do
    desc "Setup routing"
    task :setup do
      require "bunny"
  
      conn = Bunny.new
      conn.start
  
      ch = conn.create_channel
  
      # get or create exchange
      x = ch.fanout("factorial.send_number")
  
      # get or create queue (note the durable setting)
      queue = ch.queue("factorial.calculations", durable: true)
  
      # bind queue to exchange
      queue.bind("factorial.send_number")
  
      conn.close
    end
end