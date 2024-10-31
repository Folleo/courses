require 'swagger_helper'

RSpec.describe 'api/topics', type: :request do
  topic_schema = {
    type: :object,
    properties: {
      id: { type: :integer },
      name: { type: :string },
      description: { type: :string },
      created_at: { type: :string },
      updated_at: { type: :string }
    }
  }

  path '/topics' do
    get 'Retrieves all topics' do
      tags 'Topics'
      produces 'application/json'

      response '200', 'Returns all topics' do
        schema type: :array, items: topic_schema
        run_test!
      end
    end

    post 'Creates a topic' do
      tags 'Topics'
      consumes 'application/json'
      parameter name: :topic, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string }
        },
        required: [ 'name' ]
      }

      response '201', 'Topic created' do
        let(:topic) { { name: 'foo', description: 'bar' } }
        run_test!
      end

      response '422', 'Invalid request' do
        let(:topic) { { description: 'foo' } }
        run_test!
      end
    end
  end

  path '/topics/{id}' do
    let(:id) { create_topic.id }

    get 'Retrieves a topic' do
      tags 'Topics'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'Topic found' do
        schema topic_schema
        run_test!
      end

      response '404', 'Topic not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    patch 'Updates a topic' do
      let(:topic) { { name: 'New', description: 'topic' } }

      tags 'Topics'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :topic, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string }
        },
        required: [ 'name' ]
      }

      response '200', 'Topic updated' do
        run_test!
      end

      response '404', 'Topic not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '400', 'Invalid request' do
        let(:topic) { { test: 'foo' } }
        run_test!
      end
    end

    delete 'Destroys a topic' do
      tags 'Topics'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      response 204, 'No content' do
        let(:id) { create_topic.id }
        run_test!
      end

      response '404', 'Topic not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
