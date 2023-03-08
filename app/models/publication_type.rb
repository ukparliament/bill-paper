class PublicationType < ApplicationRecord
  
  has_many :publications, -> { order( 'display_date desc' ) }
end
