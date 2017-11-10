class Town < ApplicationRecord
	validates :townname, presence: true
	belongs_to :state
	validates :state_id, presence: true
	validates_uniqueness_of :townname, :scope => :state_id

  default_scope -> { order(townname: :asc)}
end
