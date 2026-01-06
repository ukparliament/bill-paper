class BillTypeController < ApplicationController
  def index
    @bill_types = BillType.all.order( 'label' )
    @page_title = 'Bill types'
    @description = 'Bill types.'
    @crumb << { label: @page_title, url: nil }
    @section = 'types'
  end
  
  def show
    bill_type = params[:bill_type]
    @bill_type = BillType.find_by_bill_system_id( bill_type )
    
    @bills = Bill.find_by_sql([
       "
         SELECT
           b.*,
           current_house.label AS current_house_name,
           originating_house.label AS originating_house_name,
           session.number AS originating_session_number,
           bill_type.label AS bill_type_label
          
         FROM bills b
        
         LEFT JOIN (
           SELECT *
           FROM parliamentary_houses
         ) AS current_house
         on current_house.id = b.current_house_id
        
         LEFT JOIN (
           SELECT *
           FROM parliamentary_houses
         ) AS originating_house
         on originating_house.id = b.originating_house_id
        
         LEFT JOIN (
           SELECT *
           FROM sessions
         ) AS session
         on session.id = b.originating_session_id
        
         LEFT JOIN (
           SELECT *
           FROM bill_types
         ) AS bill_type
         on bill_type.id = b.bill_type_id
         
         WHERE bill_type.id = ?
        
         ORDER BY b.short_title
       ", @bill_type.id
     ])
     
     @page_title = @bill_type.label
     
     respond_to do |format|
       format.html {
         @description = "#{@bill_type.label}."
         @csv_url = bill_type_show_url( :bill_type => @bill_type.bill_system_id, :format => 'csv' )
         @crumb << { label: 'Bill types', url: bill_type_list_url }
         @crumb << { label: @page_title, url: nil }
         @section = 'types'
       }
       format.csv {
         response.headers['Content-Disposition'] = "attachment; filename=\"#{csv_title_from_page_title ( @page_title )}.csv\""
         render :template => 'bill/index'
       }
    end
  end
end
