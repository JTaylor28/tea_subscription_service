class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ArgumentError, with: :handle_argument_error

  def record_not_found(exception)
    render json: ErrorSerializer.new(exception, 404).serializable_hash, status: :not_found # 404
  end

  def record_invalid(exception)
    render json: ErrorSerializer.new(exception, 422).serializable_hash, status: :unprocessable_entity # 422
  end

  def handle_argument_error(exception)
    render json: ErrorSerializer.new(exception, 422).serializable_hash, status: :unprocessable_entity # 422
  end
end
