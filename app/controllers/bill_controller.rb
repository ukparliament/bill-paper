class BillController < ApplicationController
  
  def index
    @bills = Bill.all.order( 'short_title' )
    @page_title = 'Bills'
  end
  
  def show
    bill = params[:bill]
    @bill = Bill.find_by_bill_system_id( bill )
    @page_title = @bill.short_title
    @alternate_title = "#{@page_title = @bill.short_title} - Papers"
    @rss_url = bill_show_url( :format => 'rss' )
    @csv_url = bill_show_url( :format => 'csv' )
  end
end
