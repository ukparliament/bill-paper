class BillCategory < ApplicationRecord
  
  has_many :bill_types, -> { order( :label ) }
end
