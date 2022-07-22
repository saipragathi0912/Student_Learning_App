module ExceptionHandler
    # provides the more graceful `included` method
    class AuthenticationError < StandardError; end
    class MissingToken < StandardError; end
    class InvalidToken < StandardError; end
    extend ActiveSupport::Concern
    included do
      def throw_error(message, status = :unprocessable_entity)
        json_response(message: message)
      end
    end
    private 
end