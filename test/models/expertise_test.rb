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
require "test_helper"

class ExpertiseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
