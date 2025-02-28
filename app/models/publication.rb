# == Schema Information
#
# Table name: publications
#
#  id                     :integer          not null, primary key
#  display_date           :date             not null
#  title                  :string(10000)    not null
#  bill_id                :integer          not null
#  bill_system_id         :integer          not null
#  parliamentary_house_id :integer
#  publication_type_id    :integer          not null
#
# Foreign Keys
#
#  fk_bill              (bill_id => bills.id)
#  fk_house             (parliamentary_house_id => parliamentary_houses.id)
#  fk_publication_type  (publication_type_id => publication_types.id)
#
class Publication < ApplicationRecord
  
  belongs_to :parliamentary_house, :optional => true
  belongs_to :publication_type
  belongs_to :bill
  has_many :links
  has_many :publication_files
end
