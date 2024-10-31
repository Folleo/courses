class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotDestroyed, with: :render_error

  def render_error(error)
    render json: {
      error: error.message,
      description: error.record.errors.full_messages.to_sentence
    }, status: 409
    true
  end
end
