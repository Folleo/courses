# frozen_string_literal: true

module Finders
  class RandomAuthor < AuthorBasicFinder
    def find
      Author.where.not(id: @author.id).ids.sample
    end
  end
end
