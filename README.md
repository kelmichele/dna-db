# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


CSV IMPORTS
require 'csv'
filename = File.join Rails.root, "new_towns.csv"
CSV.foreach(filename, headers: true) do |row|
  town = Town.create!(townname: row["townname"], state_id: row["state_id"])
end
