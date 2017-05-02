class List
attr_reader(:name, :id)

define_method(:initialize) do |attributes|
  @name = attributes.fetch(:name)
  @id = attributes.fetch(:id)
end

define_singleton_method(:all) do
  returned_lists = DB.exec('SELECT * FROM lists;')
  lists = []
  returned_lists.each() do |list|
    name = list.fetch('name')
    id = list.fetch('id').to_i()
    lists.push(List.new({:name => name, :id => id}))
  end
  lists
end
 define_method(:save) do
   result = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id;")
   @id = result.first().fetch("id").to_i()
 end


define_method(:==)do |another_list|
  self.name().==(another_list.name()).&(self.id().==(another_list.id()))
end
end
