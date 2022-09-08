class ApplicationController < ActionController::API
  around_action :handle_exceptions

  class NotFound < StandardError; end

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
      handle_generic_error e
    end
  end

  private

  def handle_generic_error(exception)
    error_hash = SecureRandom.hex
    render json: { message: "Unexpected error", id: error_hash }, status: :internal_server_error
    error_logger error_hash: error_hash, exception: exception
  end

  def error_logger(args)
    logger.error "[ERROR #{args[:error_hash]}] #{args[:exception].class}\n#{args[:exception].message}\n#{args[:exception].backtrace.join("\n")}"
  end
end
