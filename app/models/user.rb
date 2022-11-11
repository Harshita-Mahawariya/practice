class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :jwt_authenticatable,jwt_revocation_strategy: JwtDenylist
  has_one :cart ,dependent: :destroy
  accepts_nested_attributes_for :cart, allow_destroy: true
  has_many :orders, dependent: :destroy
  has_many :order_items, through: :orders, dependent: :destroy
  has_many :addresses
  has_many :queries ,dependent: :destroy
  has_many :likes, dependent: :destroy

  ROLE = {"Admin": 0, "Super Admin": 1, "Sub Admin": 2}

  def generate_jwt
    JWT.encode({id: id, exp: 60.days.from_now.to_i}, Rails.application.secrets.secret_key_base)
  end

end