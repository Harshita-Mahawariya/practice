class Category < ApplicationRecord
	has_many :products, dependent: :destroy
	validates :name, uniqueness: true
	accepts_nested_attributes_for :products ,allow_destroy: true
end