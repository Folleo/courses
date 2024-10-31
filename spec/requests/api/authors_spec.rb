require 'swagger_helper'

RSpec.describe 'api/authors', type: :request do
  author_schema = {
    type: :object,
    properties: {
      id: { type: :integer },
      first_name: { type: :string },
      last_name: { type: :string },
      created_at: { type: :string },
      updated_at: { type: :string }
    }
  }

  path '/authors' do
    get 'Retrieves all authors' do
      tags 'Authors'
      produces 'application/json'

      response '200', 'Returns all authors' do
        schema type: :array, items: author_schema
        run_test!
      end
    end

    post 'Creates an author' do
      tags 'Authors'
      consumes 'application/json'
      parameter name: :author, in: :body, schema: {
        type: :object,
        properties: {
          first_name: { type: :string },
          last_name: { type: :string }
        },
        required: %w[first_name last_name]
      }

      response '201', 'Author created' do
        let(:author) { { first_name: 'New', last_name: 'Author' } }
        run_test!
      end

      response '422', 'Invalid request' do
        let(:author) { { first_name: 'New' } }
        run_test!
      end
    end
  end

  path '/authors/{id}' do
    let(:id) { create_author.id }
    let(:author) { { first_name: 'New', last_name: 'Author' } }

    get 'Retrieves an author' do
      tags 'Authors'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'Author found' do
        schema author_schema
        run_test!
      end

      response '404', 'Author not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    patch 'Updates an author' do
      tags 'Authors'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :author, in: :body, schema: {
        type: :object,
        properties: {
          first_name: { type: :string },
          last_name: { type: :string }
        },
        required: %w[first_name last_name]
      }

      response '200', 'Author updated' do
        run_test!
      end

      response '404', 'Author not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '422', 'Invalid request' do
        let(:author) { { first_name: 'Bad 1', last_name: 'Last Name 2' } }
        run_test!
      end
    end

    delete 'Destroys an author' do
      tags 'Authors'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      response 204, 'No content' do
        let(:id) { create_author.id }
        create_author # just to have a replacement for Random finder
        run_test!
      end

      response '409', 'Author can not be deleted' do
        let(:id) { create_author_with_courses(5).id }
        run_test!
      end

      response '404', 'Author not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
