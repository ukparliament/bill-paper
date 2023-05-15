class BillController < ApplicationController
  
  def index
    @bills = Bill.all.order( 'short_title' )
    @page_title = 'Bills'
  end
  
  def show
    bill = params[:bill]
    @bill = Bill.find_by_bill_system_id( bill )
    @page_title = @bill.short_title
  end
end
