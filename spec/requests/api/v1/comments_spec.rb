require 'swagger_helper'

RSpec.describe 'api/v1/comments', type: :request do
  
  path '/api/v1/posts/{post_id}/comments' do

    get('list comments') do
      tags 'Comments'
      parameter name: :post_id, in: :path, type: :integer, require: true

      response(200, 'successful') do
        let(:post_id) { 1 }
        run_test!
      end

      response(404, 'not found') do
        let(:post_id) { 1000 }
        run_test!
      end
    end

    post('create comment') do
      tags 'Comments'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          body: { type: :string }
        },
        required: %i(body),
        example: { body: 'test' }
      }
      security [Bearer: []]

      response(200, 'successful') do
        let(:params) { { body: 'test' } }
        run_test!
      end

      response(400, 'missing params') do
        run_test!
      end

      response(401, 'unauthorized') do
        run_test!
      end

      response(404, 'not found') do
        let(:post_id) { 1000 }
        run_test!
      end
    end
  end

  path '/api/v1/posts/{post_id}/comments/{id}' do
    parameter name: :post_id, in: :path, type: :integer, require: true
    parameter name: :id, in: :path, type: :integer, require: true

    get('show comment') do
      tags 'Comments'

      response(200, 'successful') do
        let(:post_id) { '1' }
        let(:id) { '1' }
        run_test!
      end

      response(404, 'not found') do
        let(:post_id) { 1000 }
        let(:id) { 1000 }
        run_test!
      end
    end

    put('update comment') do
      tags 'Comments'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          body: { type: :string }
        },
        required: %i(body),
        example: { body: 'test' }
      }
      security [Bearer: []]

      response(200, 'successful') do
        let(:post_id) { 1 }
        let(:id) { 1 }
        let(:params) { { body: 'test'} }
        run_test!
      end

      response(400, 'missing param') do
        run_test!
      end

      response(401, 'unauthorized') do
        run_test!
      end

      response(404, 'not found') do
        let(:post_id) { 1000 }
        run_test!
      end
    end

    delete('delete comment') do
      tags 'Comments'
      security [Bearer: []]

      response(200, 'successful') do
        let(:post_id) { 1 }
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
