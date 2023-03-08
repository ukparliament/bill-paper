class PublicationTypeController < ApplicationController
  
  def index
    @publication_types = PublicationType.all.order( 'label' )
    @page_title = 'Publication types'
  end
  
  def show
    publication_type = params[:publication_type]
    @publication_type = PublicationType.find_by_bill_system_id( publication_type )
    @page_title = @publication_type.label
  end
end
