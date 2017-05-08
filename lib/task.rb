class Task < ActiveRecord::Base

  belongs_to(:list)

  scope(:not_done, -> do
    where({:done => false})
  end)

end
