class State < ApplicationRecord
	validates :street, presence: true
	validates :city, presence: true
	validates :zip, presence: true
	validates :statename, presence: true
	validates :abv, presence: true
end
