module JwtSupport
  extend ActiveSupport::Concern

  def request_token
    pattern = /^Bearer /
    header = request.headers[:authorization]
    header.gsub(pattern, '') if header&.match(pattern)
  end

  def payload_token
    return nil if request_token.nil?

    secrect = Rails.application.credentials.config[:secret_key_jwt]
    decoded_token = JWT.decode request_token, secrect, false
    return nil if decoded_token.size.zero?

    decoded_token[0].deep_symbolize_keys!
  end

  def current_access_token
    return nil if payload_token.nil?

    @jwt ||= AllowlistedJwt.find_jwt_payload(payload_token)
    return User.revoke_jwt(payload_token, @jwt&.user) if @jwt&.expired?

    @jwt
  end

  def sign_in(user)
    headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }

    user.generate_token(headers)
  end
end