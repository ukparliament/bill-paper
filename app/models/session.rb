class Session < ApplicationRecord
  
  def bills
    Bill.all.where( 'originating_session_id = ?', self ).order( 'short_title' )
  end
end
