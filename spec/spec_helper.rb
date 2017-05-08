ENV['RACK_ENV'] = 'test'

require("rspec")
require('sinatra/activerecord')
require("pg")
require("list")
require("task")
require('pry')

RSpec.configure do |config|
  config.after(:each) do
    Task.all().each() do |task|
      task.destroy()
    end
  end
end
