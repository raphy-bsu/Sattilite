require 'grape-swagger'
require 'action_controller/metal/strong_parameters'

module V1
  class Base < Grape::API
    # Lograge logging. Should be above mountings
    use Grape::Middleware::Lograge

    # Mounting services
    mount V1::Sensors

    add_swagger_documentation(
        api_version: 'v1',
        hide_documentation_path: true,
        mount_path: '/api/v1/swagger_doc',
        hide_format: true
    )
  end
end
