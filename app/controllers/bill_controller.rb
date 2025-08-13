class BillController < ApplicationController
  def index
    @bills = Bill.all.order( 'short_title' )
    @page_title = 'Bills'
    @description = 'Bills.'
    @crumb << { label: @page_title, url: nil }
    @section = 'bills'
  end
  
  def show
    bill = params[:bill]
    @bill = Bill.find_by_bill_system_id( bill )
    
    respond_to do |format|
      format.html {
        @page_title = @bill.short_title
        @description = "#{@bill.short_title}."
        @rss_url = bill_show_url( :format => 'rss' )
        @csv_url = bill_show_url( :format => 'csv' )
        @crumb << { label: 'Bills', url: bill_list_url }
        @crumb << { label: @page_title, url: nil }
        @section = 'bills'
      }
      format.rss
      format.csv {
        file_name = @bill.short_title.gsub( ' ', '-' ).downcase
        response.headers['Content-Disposition'] = "attachment; filename=\"papers-for-#{file_name}.csv\""
      }
    end
  end
end
