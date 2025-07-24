class BillCategoryController < ApplicationController
  def index
    @bill_categories = BillCategory.all.order( 'label' )
    @page_title = 'Bill categories'

    @crumb << { label: @page_title, url: nil }
  end
  
  def show
    bill_category = params[:bill_category]
    @bill_category = BillCategory.find( bill_category )
    @page_title = "#{@bill_category.label} bills"

    @crumb << { label: 'Bill categories', url: bill_category_list_url }
    @crumb << { label: @page_title, url: nil }
  end
end
