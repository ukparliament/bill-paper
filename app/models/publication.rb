class Publication < ApplicationRecord
  
  belongs_to :parliamentary_house, :optional => true
  belongs_to :publication_type
  belongs_to :bill
  has_many :links
end
