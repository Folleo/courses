# == Schema Information
#
# Table name: courses
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  author_id   :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Course < ApplicationRecord
  belongs_to :author
  has_many :expertises, dependent: :destroy
  has_many :topics, through: :expertises

  validates :name, :author_id, presence: true

  def self.attribute_names
    super + [ "topic_ids" ]
  end

  def attribute_names
    self.class.attribute_names
  end
end
