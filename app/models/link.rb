class Link < ApplicationRecord
  
  belongs_to :publication
  belongs_to :content_type

  def display_title
    self.title || 'Untitled'
  end
  
  def description
    description = "#{self.publication.publication_type.label} - for the #{self.publication.bill.short_title} published on #{self.publication.display_date}"
    description += " #{self.content_type.display_label}"
    description
  end
  
  def content_type_display_label
    display_label = ''
    case self.content_type_content_type
      when 'application/pdf'
        display_label = 'PDF'
      when 'text/html' || 'application/xhtml+xml'
        display_label = 'HTML'
      when 'application/octet-stream'
        display_label = 'Binary'
      when 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' || 'application/msword'
        display_label = 'MS Word'
      when 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        display_label = 'MS Excel'
      when 'image/tiff'
        display_label = 'TIFF image'
      end
    display_label = '[' + display_label + ']'
  end
end
