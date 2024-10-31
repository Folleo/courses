# frozen_string_literal: true

class AuthorReplacer
  def initialize(author:)
    @author = author
    # Illustrates, that we can change finder strategy on the fly
    finder_class = @author.topics.count > 2 ? Finders::SimilarTopicsAuthor : Finders::RandomAuthor
    @author_finder = finder_class.new(author:)
  end

  def perform
    new_author_id = @author_finder.find
    return false if new_author_id.nil? || new_author_id == @author.id

    courses_count = @author.courses.count
    updated_courses = @author.courses.update_all(author_id: new_author_id)

    courses_count == updated_courses
  end
end
