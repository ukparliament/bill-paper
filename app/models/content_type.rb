class ContentType < ApplicationRecord
  
  def display_label
    display_label = ''
    case self.content_type
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
