class Link < ApplicationRecord
  
  belongs_to :publication
  belongs_to :content_type
  
  def description
    description = "#{self.publication.publication_type.label} - for the #{self.publication.bill.short_title} published on #{self.publication.display_date}"
    description += " #{self.content_type.display_label}"
    description
  end
end
