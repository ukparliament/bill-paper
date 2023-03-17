class MetaController < ApplicationController
  
  def index
    @page_title = 'Meta'
  end
  
  def schema
    @page_title = 'Database schema'
  end
  
  def bookmarklet
    @page_title = 'Bookmarklet'
  end
end
