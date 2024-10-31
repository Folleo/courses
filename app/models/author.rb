# == Schema Information
#
# Table name: authors
#
#  id         :bigint           not null, primary key
#  first_name :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Author < ApplicationRecord
  has_many :courses
  has_many :topics, through: :courses
  has_many :expertises, through: :courses

  before_destroy :reassign_courses, prepend: true

  validates :first_name, presence: true, format: { with: /\A[a-zA-Z]+\z/ }
  validates :last_name, presence: true, format: { with: /\A[a-z ,.'-]+\z/i }

  private

  def reassign_courses
    replacement_result = AuthorReplacer.new(author: self).perform

    unless replacement_result
      self.errors.add(:base, "Can't be destroyed because of missing author replacement")
      throw :abort
    end
  end
end
