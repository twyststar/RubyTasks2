require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/task')
require('./lib/list')
require('pry')
require('pg')

DB = PG.connect({:dbname => "to_do"})

get("/") do
  @lists = List.all()
  erb(:index)
end

post("/lists") do
  name = params.fetch("name")
  list = List.new({:name => name, :id => nil})
  list.save()
  @lists = List.all()
  erb(:index)
end

get("/lists/:id") do
 @list = List.find(params.fetch("id").to_i())
 @tasks = Task.all()
 erb(:list)
end

post("/tasks") do
  description = params.fetch("description")
  list_id = params.fetch("list_id").to_i()
  task = Task.new({:description => description, :list_id => list_id})
  task.save()
  @tasks = Task.all()
  @list = List.find(list_id)
  erb(:list)
end

get("/lists/:id/edit") do
  @list = List.find(params.fetch("id").to_i())
  erb(:list_edit)
end

patch("/lists/:id") do
  name = params.fetch("name")
  @list = List.find(params.fetch("id").to_i())
  @list.update({:name => name})
  @tasks = Task.all()
  erb(:list)
end
delete("/lists/:id") do
  @list = List.find(params.fetch("id").to_i())
  @list.delete()
  @lists = List.all()
  erb(:index)
end
