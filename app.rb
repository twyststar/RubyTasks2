require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/task')
require('./lib/list')
require('pry')
require('pg')

DB = PG.connect({:dbname => "to_do"})

get('/') do
  @tasks = Task.all()
  erb(:index)
end

post("/tasks")do
  description= params.fetch("description")
  task = Task.new(description)
  task.save()
  erb(:results)
end
