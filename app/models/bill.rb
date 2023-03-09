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
  
  def links
    Link.find_by_sql(
      "
        SELECT 
          l.*, ct.content_type AS content_type_content_type,
          p.display_date AS publication_display_date,
          b.short_title AS bill_short_title,
          pt.label AS publication_type_label,
          b.bill_system_id AS bill_bill_system_id,
          pt.bill_system_id AS publication_type_bill_system_id,
          p.title AS publication_title
        FROM links as l, publications as p, bills b, publication_types pt, content_types ct
        WHERE l.publication_id = p.id
        AND p.publication_type_id = pt.id
        AND b.id = #{self.id}
        AND l.content_type_id = ct.id
        AND p.bill_id = b.id
        ORDER BY p.display_date desc
      "
    )
  end
end
