# frozen_string_literal: true

module Finders
  class SimilarTopicsAuthor < AuthorBasicFinder
    SQL_QUERY = IO.read("lib/finders/sql/similar_topics_author.sql")

    def find
      sanitized_sql = ApplicationRecord.sanitize_sql([ SQL_QUERY, { author_id: @author.id } ])
      result = ActiveRecord::Base.connection.execute(sanitized_sql)

      return nil if result.count.zero?

      result.first["author_id"]
    end
  end
end
