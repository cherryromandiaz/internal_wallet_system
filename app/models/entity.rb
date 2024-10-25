class Entity < ApplicationRecord
  self.abstract_class = true
  self.table_name = 'entities'
  has_one :wallet, as: :owner, dependent: :destroy
end
