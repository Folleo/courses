# == Schema Information
#
# Table name: courses_expertises
#
#  id           :bigint           not null, primary key
#  course_id    :bigint           not null
#  expertise_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require "test_helper"

class CoursesExpertiseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
