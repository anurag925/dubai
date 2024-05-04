# frozen_string_literal: true

# module responsible for handling auth authorization_handler
module AuthorizationHandler
  extend ActiveSupport::Concern
  include RenderResponse

  def authorize_user!
    return json_unauthorized(msg: 'Authentication failed') unless jwt_token
    return json_unauthorized(msg: 'Authentication failed invalid jwt') unless jwt_payload

    @current_user = User.find_by(id: jwt_payload[:id])
  end

  def authorize_admin!
    authorize_user!

    json_unauthorized(msg: 'Admin auth failed') unless @current_user.admin?
  end

  private

  def jwt_payload
    @jwt_payload ||= Utils::Jwt.decode(jwt_token)
  end

  def jwt_token
    (request.headers['Authorization'] || '').split.last
  end
end
