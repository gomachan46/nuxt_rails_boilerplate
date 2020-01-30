class ApplicationController < ActionController::API
  before_action :set_host_for_local_storage

  def render_404
    render json: '', status: :not_found and return
  end

  private def set_host_for_local_storage
    ActiveStorage::Current.host = request.base_url if Rails.application.config.active_storage.service == :local
  end
end
