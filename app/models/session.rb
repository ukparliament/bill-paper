class Session < ApplicationRecord
  
  def bills
    Bill.where( 'originating_session_id = ?', self )
  end
end
