require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do

  path '/api/v1/users' do
    post('sign up') do
      tags 'Auth'
      consumes 'application/json'

      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          api_v1_user: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string },
              password_confirmation: { type: :string }
            },
            required: %i(email password password_confirmation),
          }
        },
        required: %i(api_v1_user),
        example: {
          api_v1_user: { email: 'example@test.com', password: '12345678', password_confirmation: '12345678' }
        }
      }

      response(200, 'successful') do
        let(:params) { { api_v1_user: { email: 'exmple@test.com', password: '12345678', password_confirmation: '12345678' } } }
        run_test!
      end

      response(400, 'missing param') do
        run_test!
      end

      response(422, 'invalid email or password') do
        let(:params) { { api_v1_user: { email: 'exmple@test.com', password: '?', password_confirmation: 'x' } } }
        run_test!
      end
    end
  end

  path '/api/v1/users/sign_in' do
    post('login') do
      tags 'Auth'
      consumes 'application/json'

      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          api_v1_user: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string }
            },
            required: %i(email password),
          }
        },
        required: %i(api_v1_user),
        example: {
          api_v1_user: { email: 'example@test.com', password: '12345678' }
        }
      }

      response(200, 'successful') do
        let(:params) { { api_v1_user: { email: 'exmple@test.com', password: '12345678' } } }
        run_test!
      end

      response(400, 'missing param') do
        run_test!
      end

      response(401, 'unauthorized, wrong email or password') do
        let(:params) { { api_v1_user: { email: 'exmple@test.com', password: 'abcdefgh' } } }
        run_test!
      end
    end
  end

  path '/api/v1/users/sign_out' do
    delete('logout') do
      tags 'Auth'
      consumes 'application/json'
      security [{ Bearer: {} }]

      response(200, 'successful') do
        run_test!
      end

      response(401, 'unauthorized, missing token or token expired') do
        run_test!
      end
    end
  end

end