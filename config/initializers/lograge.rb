Rails.application.configure do
  config.lograge.enabled = true

  # Extension to log incoming request parameters
  config.lograge.custom_options = lambda do |event|
    params = event.payload[:params].reject { |k| %w(controller action).include?(k) }
    { 'params' => params }
  end
end
