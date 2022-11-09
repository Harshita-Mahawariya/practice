class Variant < ApplicationRecord
	has_many :variant_properties, dependent: :destroy
	accepts_nested_attributes_for :variant_properties, allow_destroy: true
	validates :name, uniqueness: true
end
