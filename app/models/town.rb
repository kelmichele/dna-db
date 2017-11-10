class Town < ApplicationRecord
	validates :townname, presence: true
	belongs_to :state
	validates :state_id, presence: true

  default_scope -> { order(townname: :asc)}
end
