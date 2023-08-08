class PublicationTypeController < ApplicationController
  
  def index
    @publication_types = PublicationType.all.order( 'label' )
    @page_title = 'Publication types'
    @alternate_title = 'Publication types'
    @csv_url = publication_type_list_url( :format => 'csv' )
  end
  
  def show
    publication_type = params[:publication_type]
    @publication_type = PublicationType.find_by_bill_system_id( publication_type )
    @page_title = @publication_type.label
    @alternate_title = @publication_type.label
    @rss_url = publication_type_show_url( :format => 'rss' )
    @csv_url = publication_type_show_url( :format => 'csv' )
  end
end
