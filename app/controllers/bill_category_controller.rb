class BillCategoryController < ApplicationController
  
  def index
    @bill_categories = BillCategory.all.order( 'label' )
    @page_title = 'Bill categories'
  end
  
  def show
    bill_category = params[:bill_category]
    @bill_category = BillCategory.find( bill_category )
    @page_title = "#{@bill_category.label} bills"
  end
end
