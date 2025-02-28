# == Schema Information
#
# Table name: parliamentary_houses
#
#  id          :integer          not null, primary key
#  label       :string(255)      not null
#  short_label :string(255)      not null
#
class ParliamentaryHouse < ApplicationRecord
end
