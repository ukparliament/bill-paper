class PublicationFile < ApplicationRecord
  
  belongs_to :publication
  belongs_to :content_type
  
  def url
    "https://bills.parliament.uk/publications/#{self.publication.bill_system_id}/documents/#{self.bill_system_id}"
  end
end
