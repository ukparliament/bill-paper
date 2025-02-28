# == Schema Information
#
# Table name: bill_types
#
#  id               :integer          not null, primary key
#  description      :text             not null
#  label            :string(255)      not null
#  bill_category_id :integer          not null
#  bill_system_id   :integer          not null
#
# Foreign Keys
#
#  fk_bill_category  (bill_category_id => bill_categories.id)
#
class BillType < ApplicationRecord
  
  belongs_to :bill_category
  has_many :bills, -> { order( :short_title ) }
end
