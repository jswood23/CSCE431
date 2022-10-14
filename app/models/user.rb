# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  has_one :information, dependent: :destroy

  accepts_nested_attributes_for :information, allow_destroy: true

  def self.from_omniauth(auth)
    if self.where(email: auth.info.email).exists?
      return_user = self.where(email: auth.info.email).first
      return_user.provider = auth.provider
      return_user.uid = auth.uid
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        user.full_name = auth.info.name
        user.avatar_url = auth.info.image
      end
    end
    return_user
  end
end
