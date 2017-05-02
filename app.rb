require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/task')
require('./lib/list')
require('pry')
require('pg')

DB = PG.connect({:dbname => "to_do_test"})

get('/') do
  @tasks = Task.all()
  erb(:index)
end

get("/lists/new") do
  erb(:list_form)
end

post("/lists") do
  name = params.fetch("name")
  list = List.new({:name => name, :id => nil})
  list.save()
  erb(:success)
 end
 get('/lists') do
  @lists = List.all()
  erb(:lists)
end
get("/lists/:id") do
 @list = List.find(params.fetch("id").to_i())
 erb(:list)
end
post("/tasks") do
  description = params.fetch("description")
  list_id = params.fetch("list_id").to_i()
  @list = List.find(list_id)
  @task = Task.new({:description => description, :list_id => list_id})
  @task.save()
  erb(:success)
end
# post("/tasks")do
#   description= params.fetch("description")
#   task = Task.new(description)
#   task.save()
#   erb(:results)
# end
