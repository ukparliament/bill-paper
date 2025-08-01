class MetaController < ApplicationController
  def index
    @page_title = 'Meta'

    @crumb << { label: 'About this website', url: nil }
  end
  
  def schema
    @page_title = 'Database schema'

    @crumb << { label: 'About this website', url: meta_list_url }
    @crumb << { label: @page_title, url: nil }
  end
  
  def bookmarklet
    @page_title = 'Bookmarklet'

    @crumb << { label: 'About this website', url: meta_list_url }
    @crumb << { label: @page_title, url: nil }
  end
  
  def cookies
    @page_title = 'Cookies'

    @crumb << { label: 'About this website', url: meta_list_url }
    @crumb << { label: @page_title, url: nil }

    render 'library_design/meta/cookies'
  end
end
