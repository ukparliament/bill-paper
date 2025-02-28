# == Schema Information
#
# Table name: bill_categories
#
#  id    :integer          not null, primary key
#  label :string(255)      not null
#
class BillCategory < ApplicationRecord
  
  has_many :bill_types, -> { order( :label ) }
end
