# == Schema Information
#
# Table name: expertises
#
#  id         :bigint           not null, primary key
#  course_id  :bigint           not null
#  topic_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Expertise < ApplicationRecord
  belongs_to :course
  belongs_to :topic

  validates :topic, presence: true
  validates :course, presence: true, uniqueness: { scope: :topic }
end
