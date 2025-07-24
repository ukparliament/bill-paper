class BillTypeController < ApplicationController
  def index
    @bill_types = BillType.all.order( 'label' )
    @page_title = 'Bill types'

    @crumb << { label: @page_title, url: nil }
  end
  
  def show
    bill_type = params[:bill_type]
    @bill_type = BillType.find_by_bill_system_id( bill_type )
    @page_title = @bill_type.label

    @crumb << { label: 'Bill types', url: bill_type_list_url }
    @crumb << { label: @page_title, url: nil }
  end
end
