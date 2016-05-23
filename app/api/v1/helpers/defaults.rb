module V1
  module Helpers
    module Defaults
      extend ActiveSupport::Concern

      included do
        prefix 'api'
        version 'v1', using: :path
        default_format :json
        format :json
        formatter :json, Grape::Formatter::ActiveModelSerializers

        helpers do
          extend Grape::API::Helpers

          class AccessDenied < StandardError; end

          def permitted_params
            @permitted_params ||= declared(params, include_missing: false)
          end

          def authenticate!
            fail AccessDenied unless current_user
          end

          def authenticate_current_user!(user_id)
            fail AccessDenied unless current_user && (current_user.id == user_id || current_user.admin?)
          end

          def authenticate_admin!
            fail AccessDenied unless current_user && current_user.admin?
          end

          def current_user
            @current_user ||= find_current_user
          end

          protected

          def find_current_user
            if Rails.env.test?
              User.user.first
            else
              request.env['warden'].authenticate(scope: :user)
            end
          end
        end

        rescue_from Grape::Exceptions::ValidationErrors do |e|
          rack_response({
                            error: 'invalid_params',
                            messages: [e.message]
                        }.to_json, 400)
        end

        rescue_from AccessDenied do |e|
          rack_response({
                            error: 'access_denied',
                            messages: [e.message]
                        }.to_json, 401)
        end

        rescue_from ActiveRecord::RecordNotFound do |e|
          rack_response({
                            error: 'record_not_found',
                            messages: [e.message]
                        }.to_json, 404)
        end

        rescue_from ActiveRecord::RecordInvalid do |e|
          Rails.logger.error("#{e.message}\n#{e.backtrace.join("\n")}")
          rack_response({
                            error: 'record_invalid',
                            messages: [e.message]
                        }.to_json, 422)
        end

        rescue_from StandardError do |e|
          Rails.logger.error("#{e.message}\n#{e.backtrace.join("\n")}")
          rack_response({
                            error: 'unknown_error',
                            messages: [e.message]
                        }.to_json, 500)
        end
      end
    end
  end
end
