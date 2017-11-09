class State < ApplicationRecord
	validates :name, presence: true
	validates :abv, presence: true
	has_many :towns, dependent: :destroy
end
