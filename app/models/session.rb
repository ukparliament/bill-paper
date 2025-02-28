# == Schema Information
#
# Table name: sessions
#
#  id                  :integer          not null, primary key
#  commons_description :string(255)      not null
#  end_on              :date             not null
#  lords_description   :string(255)      not null
#  number              :string(255)      not null
#  parliament_number   :integer          not null
#  session_number      :integer          not null
#  start_on            :date             not null
#  bill_system_id      :integer          not null
#
class Session < ApplicationRecord
  
  def bills
    Bill.all.where( 'originating_session_id = ?', self ).order( 'short_title' )
  end
end
