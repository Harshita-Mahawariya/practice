class Query < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_many :replies, class_name: "Query", foreign_key: "answer_id",dependent: :destroy
  has_many :likes, as: :likeable,dependent: :destroy 
  belongs_to :answer, class_name: "Query", optional: true
  accepts_nested_attributes_for :replies, allow_destroy: true
  validates :description, presence: true
end