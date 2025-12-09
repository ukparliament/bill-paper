class SessionController < ApplicationController
  
  def index
    @sessions = Session.all.order( 'start_on desc' )
    @page_title = 'Sessions'
    @description = 'Sessions of the UK Parliament.'
    @crumb << { :label => 'Sessions', :url => nil }
    @section = 'sessions'
  end
  
  def show
    session = params[:session]
    @session = Session.find_by_bill_system_id( session )
    raise ActiveRecord::RecordNotFound unless @session
    @bills = @session.bills
    
    @page_title = "#{@session.session_number.ordinalize} session of the #{@session.parliament_number.ordinalize} Parliament"
    @description = "#{@session.session_number.ordinalize} session of the #{@session.parliament_number.ordinalize} Parliament of the United Kingdom."
    @crumb << { :label => 'Sessions', :url => session_list_url }
    @crumb << { :label => "#{@session.session_number.ordinalize} session of the #{@session.parliament_number.ordinalize} Parliament", :url => nil }
    @section = 'sessions'
  end
end
