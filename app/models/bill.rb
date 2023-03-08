class Bill < ApplicationRecord
  
  belongs_to :bill_type
  has_many :publications, -> { order( :display_date ) }
  
  def originating_house
    ParliamentaryHouse.find( self.originating_house_id ) if self.originating_house_id
  end
  
  def current_house
    ParliamentaryHouse.find( self.current_house_id ) if self.current_house_id
  end
  
  def originating_session
    Session.find( self.originating_session_id )
  end
end
