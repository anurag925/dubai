# frozen_string_literal: true

# app/middleware/request_response_logger.rb

module Middlewares
  # logs request and response of a request
  class RequestResponseLogger
    def initialize(app)
      @app = app
    end

    def call(env)
      request = ActionDispatch::Request.new(env)

      # Log the request
      Rails.logger.info("Request: #{request.method} #{request.fullpath} - Parameters: #{request.parameters}")

      # Call the next middleware in the stack
      status, headers, response = @app.call(env)

      # Log the response
      Rails.logger.info("Response: #{status} #{headers} - Body: #{response}")

      [status, headers, response]
    end
  end
end
