# == Schema Information
#
# Table name: links
#
#  id              :integer          not null, primary key
#  content_length  :integer
#  source          :string(20)       not null
#  title           :string(10000)    not null
#  url             :string(10000)    not null
#  bill_system_id  :integer          not null
#  content_type_id :integer          not null
#  publication_id  :integer          not null
#
# Foreign Keys
#
#  fk_content_type  (content_type_id => content_types.id)
#  fk_publication   (publication_id => publications.id)
#
class Link < ApplicationRecord
  
  belongs_to :publication
  belongs_to :content_type

  def display_title
    self.title || 'Untitled'
  end
  
  def description
    description = "#{self.publication_type_label} - for the #{self.bill_short_title} published on #{self.publication_display_date}"
    description += " #{self.content_type_display_label}"
    description
  end
  
  def content_type_display_label
    display_label = ''
    case self.content_type_content_type
      when 'application/pdf'
        display_label = 'PDF'
      when 'text/html', 'application/xhtml+xml'
        display_label = 'HTML'
      when 'application/octet-stream'
        display_label = 'Binary'
      when 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'application/msword'
        display_label = 'MS Word'
      when 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        display_label = 'MS Excel'
      when 'image/tiff'
        display_label = 'TIFF image'
      end
    display_label = '[' + display_label + ']'
  end
end
