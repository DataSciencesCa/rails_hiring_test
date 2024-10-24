class Riding < ApplicationRecord
  has_many :polls, dependent: :destroy
  has_many :polling_locations, dependent: :destroy

  validates :name, presence: true
  validates :riding_code, presence: true
  validates :province, presence: true

  accepts_nested_attributes_for :polling_locations, allow_destroy: true
end
