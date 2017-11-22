class State < ApplicationRecord
	extend FriendlyId
  friendly_id :name

	validates :name, presence: true
	validates :abv, presence: true
	has_many :towns, dependent: :destroy
	has_many :clinics, through: :towns


  default_scope -> { order(name: :asc)}
# State.find_each(&:save)
end
