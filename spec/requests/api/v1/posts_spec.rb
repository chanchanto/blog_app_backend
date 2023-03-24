require 'swagger_helper'

RSpec.describe 'api/v1/posts', type: :request do

  path '/api/v1/posts' do
    get('list posts') do
      tags 'Posts'
      consumes 'application/json'

      response(200, 'successful') do
        run_test!
      end
    end
    
    post('create post') do
      tags 'Posts'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          content: { type: :string }
        },
        required: %i(title content),
        example: { title: 'test', content: 'test' }
      }
      security [Bearer: []]

      response(200, 'successful') do
        let(:params) { { title: 'test', content: 'test' } }
        run_test!
      end

      response(401, 'unauthorized') do
        run_test!
      end
    end
  end

  path '/api/v1/posts/{id}' do
    parameter name: :id, in: :path, type: :integer, required: true

    get('show post') do
      tags 'Posts'
      consumes 'application/json'

      response(200, 'successful') do
        let(:id) { 1 }
        run_test!
      end

      response(404, 'not found') do
        let(:id) { 1000 }
        run_test!
      end
    end

    put('update post') do
      tags 'Posts'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          content: { type: :string }
        },
        required: %i(title content),
        example: { title: 'test', content: 'test' }
      }
      security [Bearer: {}]

      response(200, 'successful') do
        let(:id) { 1 }
        let(:params) { { title: 'test', content: 'test' } }
        run_test!
      end

      response(401, 'unauthorized') do
        run_test!
      end

      response(404, 'not found') do
        let(:id) { 1000 }
        run_test!
      end
    end

    delete('delete post') do
      tags 'Posts'
      consumes 'application/json'
      security [Bearer: {}]

      response(204, 'successful') do
        let(:id) { 1 }
        run_test!
      end

      response(401, 'unauthorized') do
        run_test!
      end

      response(404, 'not found') do
        let(:post_id) { 1000 }
        let(:id) { 1000 }
        run_test!
      end
    end
  end
end
