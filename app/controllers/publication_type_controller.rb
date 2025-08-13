class PublicationTypeController < ApplicationController
  def index
    @publication_types = PublicationType.all.order( 'label' )
    @page_title = 'Publication types'
    @description = 'Publication types.'
    @csv_url = publication_type_list_url( :format => 'csv' )
    @crumb << { label: @page_title, url: nil }
    @section = 'publication-types'
  end
  
  def show
    publication_type = params[:publication_type]
    @publication_type = PublicationType.find_by_bill_system_id( publication_type )
    
    respond_to do |format|
      format.html {
        @page_title = @publication_type.label
        @description = "#{@publication_type.label}."
        @rss_url = publication_type_show_url( :format => 'rss' )
        @csv_url = publication_type_show_url( :format => 'csv' )
        @crumb << { label: 'Publication types', url: publication_type_list_url }
        @crumb << { label: @page_title, url: nil }
        @section = 'publication-types'
      }
      format.rss
      format.csv {
        file_name = @publication_type.label.gsub( ' ', '-' ).downcase
        response.headers['Content-Disposition'] = "attachment; filename=\"#{file_name}.csv\""
      }
    end
  end
end
