class SessionController < ApplicationController
  
  def index
    @sessions = Session.all.order( 'start_on desc' )
    @page_title = 'Sessions'
  end
  
  def show
    session = params[:session]
    @session = Session.find_by_bill_system_id( session )
    raise ActiveRecord::RecordNotFound unless @session
    @page_title = "Session #{@session.session_number} of the #{@session.parliament_number.ordinalize} Parliament"
    @bills = @session.bills
  end
end
