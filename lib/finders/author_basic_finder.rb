# frozen_string_literal: true
module Finders
  class AuthorBasicFinder
    def initialize(author:)
      @author = author
    end

    protected

    def find
      raise NotImplementedError
    end
  end
end
