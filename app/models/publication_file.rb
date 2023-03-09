class PublicationFile < ApplicationRecord
  
  belongs_to :publication
  belongs_to :content_type
  
  def url
    "https://bills.parliament.uk/publications/#{self.publication.bill_system_id}/documents/#{self.bill_system_id}"
  end
  
  def description
    description = "#{self.publication.publication_type.label} - for the #{self.publication.bill.short_title} published on #{self.publication.display_date}"
    description += " #{self.content_type.display_label}"
    description
  end
end
