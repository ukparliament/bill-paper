class BillController < ApplicationController
  
  def index

   @bills = Bill.find_by_sql(
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
        
        ORDER BY b.short_title
      "
    )
    
    respond_to do |format|
      format.html {
        @page_title = 'Bills'
        @description = 'Bills.'
        @csv_url = bill_list_url( :format => 'csv' )
        @crumb << { label: @page_title, url: nil }
        @section = 'bills'
      }
      format.csv {
      }
    end
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
