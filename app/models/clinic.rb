class Clinic < ApplicationRecord
	validates :address, presence: true
  validates :zipcode, presence: true
  validates_uniqueness_of :address
	belongs_to :town
  has_one :state, through: :town
  validates :town_id, presence: true

 	def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      clinic = find_by(address: row["address"]) || new
      clinic.attributes = row.to_hash
      clinic.save!
    end
  end

end
