class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :cart ,dependent: :destroy
  accepts_nested_attributes_for :cart, allow_destroy: true
  has_many :orders, dependent: :destroy
  has_many :order_items, through: :orders, dependent: :destroy
  has_many :addresses
  has_many :queries ,dependent: :destroy
  has_many :likes, dependent: :destroy
end