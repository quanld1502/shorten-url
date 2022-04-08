class AllowlistedJwt < ApplicationRecord
  belongs_to :user

  def self.find_jwt_payload(payload)
    find_by(user_id: payload[:sub], jti: payload[:jti])
  end

  def expired?
    exp.to_i <= Time.current.to_i
  end
end
