# frozen_string_literal: true

class User < ApplicationRecord
  include ApplicationHelper

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  has_one :information, dependent: :destroy

  accepts_nested_attributes_for :information, allow_destroy: true

  def self.from_omniauth(auth)
    if exists?(email: auth.info.email)
      return_user = where(email: auth.info.email).first
      return_user.provider = auth.provider
      return_user.uid = auth.uid
      return_user.avatar_url = auth.info.image
      return_user.save!
      return_user
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        user.full_name = auth.info.name
        user.avatar_url = auth.info.image
      end
    end
  end

  after_create do |_this_user|
    create_all_user_scores
  end

  after_destroy do |this_user|
    UserScore.where(user_id: this_user.id).delete_all
    AttendanceRecord.where(uid: this_user.id).delete_all
  end
end
