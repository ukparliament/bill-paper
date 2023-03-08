class Link < ApplicationRecord
  
  belongs_to :publication
  belongs_to :content_type
end
