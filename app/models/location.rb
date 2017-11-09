class State < ApplicationRecord
	validates :city, presence: true
	validates :zip, presence: true
	validates :statename, presence: true
end
