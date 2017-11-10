require 'csv'
filename = File.join Rails.root, "dna_town.csv"
CSV.foreach(filename, headers: true) do |row|
	town_hash = row.to_hash
  town = Town.create!(townname: row["townname"], state_id: row["state_id"])
  # Town.create!(town_hash)
end
