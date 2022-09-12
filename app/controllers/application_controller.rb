class ApplicationController < ActionController::API
  around_action :handle_exceptions

  # I chose to handle exceptions in a single place in the code
  def handle_exceptions
    begin
      yield
    rescue ActiveRecord::RecordInvalid => e
      render json: { message: e.message }, status: :bad_request
    rescue ActiveRecord::RecordNotFound
      render json: { message: 'Record not found' }, status: :not_found
    rescue ArgumentError => e
      render json: { message: e.message }, status: :bad_request
    rescue => e
      # When there is an unhandled error, a random hash will appear on the response.
      # This way we can find a particular error by searching in the logs for this hash
      error_hash = SecureRandom.hex
      render json: { message: "Unexpected error", id: error_hash }, status: :internal_server_error
      error_logger error_hash: error_hash, exception: exception
    end
  end

  private

  def error_logger(args)
    # A more sophisticated error logging could be implemented, using Sentry or some other engine
    logger.error "[ERROR #{args[:error_hash]}] #{args[:exception].class}\n#{args[:exception].message}\n#{args[:exception].backtrace.join("\n")}"
  end
end
