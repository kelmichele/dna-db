class Location < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :street, presence: true
  validates :zip, presence: true
  # validates_uniqueness_of :full_address

  belongs_to :town
  validates :town_id, presence: true
  has_one :state, through: :town

  default_scope -> { order(street: :asc)}

  def address
    [street, city_state, zip].compact.join(" , ")
  end

  def city_state
    "#{town.townname}, #{state.abv}"
  end

  def full_address
    "#{street}" + "\n" + "#{town.townname}, #{state.abv} #{zip}" + "\n" + "(#{latitude}, #{longitude})"
  end

  def address_changed?
    street_changed? || town_id_changed? || zip_changed?
  end

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
