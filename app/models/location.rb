class Location < ApplicationRecord

  validates :street, presence: true, uniqueness: { scope: :city, case_sensitive: false }
	validates :city, presence: true, uniqueness: { scope: :state, case_sensitive: false }
  validates :state, presence: true
  validates :abrv, presence: true
  validates :zip, presence: true


 	def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      location = find_by(street: row["street"]) || new
      location.attributes = row.to_hash
      location.save!
    end
  end

end
