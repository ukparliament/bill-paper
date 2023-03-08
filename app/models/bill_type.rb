class BillType < ApplicationRecord
  
  belongs_to :bill_category
  has_many :bills, -> { order( :short_title ) }
end
