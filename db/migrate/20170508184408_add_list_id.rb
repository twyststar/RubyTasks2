class AddListId < ActiveRecord::Migration[5.1]
  def change
    add_column(:tasks, :list_id, :int)
  end
end
