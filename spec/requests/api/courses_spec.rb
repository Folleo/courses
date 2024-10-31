require 'swagger_helper'

RSpec.describe 'api/courses', type: :request do
  course_schema = {
    type: :object,
    properties: {
      id: { type: :integer },
      name: { type: :string },
      description: { type: :string },
      author_id: { type: :integer },
      topic_ids: { type: :array, items: { type: :integer } },
      created_at: { type: :string },
      updated_at: { type: :string }
    }
  }

  path '/courses' do
    get 'Retrieves all courses' do
      tags 'Courses'
      produces 'application/json'

      response '200', 'Returns all courses' do
        schema type: :array, items: course_schema
        run_test!
      end
    end

    post 'Creates a course' do
      tags 'Courses'
      consumes 'application/json'
      parameter name: :course, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          author_id: { type: :string },
          topic_ids: { type: :array, items: { type: :integer } } },
        required: %w[name author_id]
      }

      response '201', 'Course created' do
        let(:course) { {
          name: 'Test',
          description: 'Course',
          author_id: create_author.id,
          topic_ids: [ create_topic.id ]
        } }
        run_test!
      end

      response '422', 'Invalid request' do
        let(:course) { { description: 'foo' } }
        run_test!
      end
    end
  end

  path '/courses/{id}' do
    let(:id) { create_course.id }

    get 'Retrieves a course' do
      tags 'Courses'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'Course found' do
        schema course_schema
        run_test!
      end

      response '404', 'Course not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    patch 'Updates a course' do
      let(:course) { { description: 'test' } }

      tags 'Courses'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :course, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          author_id: { type: :string },
          topic_ids: { type: :array, items: { type: :integer } }
        }
      }

      response '200', 'Course updated' do
        run_test!
      end

      response '404', 'Course not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '422', 'Invalid request' do
        let(:course) { { author_id: 'not_existing_id' } }
        run_test!
      end
    end

    delete 'Destroys a course' do
      tags 'Courses'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      response 204, 'No content' do
        let(:id) { create_course.id }
        run_test!
      end

      response '404', 'Course not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
