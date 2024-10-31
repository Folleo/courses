# == Schema Information
#
# Table name: topics
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Topic < ApplicationRecord
  has_many :courses
  has_many :authors, through: :courses
  has_many :expertises, dependent: :destroy

  validates :name, presence: true
end
