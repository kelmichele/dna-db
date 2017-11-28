class Location < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :street, presence: true, uniqueness: { scope: :city }
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true


  # default_scope -> { order(state: :asc)}
  # default_scope -> { order(city: :asc)}
  # default_scope -> { order(zip: :asc)}

  def address
    [street, city, state, zip].compact.join(" , ")
  end

  def full_address
    "#{street}" + "\n" + "#{city}, #{state} #{zip}" + "\n" + "(#{latitude}, #{longitude})"
  end

  def address_changed?
    street_changed? || city_changed? || state_changed? || zip_changed?
  end

  # searchkick locations: [:position]
  # def search_data
  #   attributes.merge position: { lat: latitude, lon: longitude }
  # end

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
