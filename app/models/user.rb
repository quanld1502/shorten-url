class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Allowlist
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: ::AllowlistedJwt
  has_many :links

  def generate_token(headers = {})
    headers[Warden::JWTAuth.config.aud_header]

    token, payload = Warden::JWTAuth::UserEncoder.new.call(
      self, :user, Warden::JWTAuth.config.aud_header
    )

    on_jwt_dispatch(token, payload) if respond_to?(:on_jwt_dispatch)

    token
  end

  def on_jwt_dispatch(token, payload) # rubocop:disable Lint/UselessMethodDefinition
    super
  end
end
