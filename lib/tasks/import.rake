namespace :import_dna do
  desc 'Import location data from CSV to database'
  task :import_loc => :environment do
    s3 = Aws::S3::Resource.new(
      region: 'region',
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    )
    obj = s3.bucket(ENV['S3_BUCKET_TITLE']).object('key').get
    CSV.parse(obj.body, :headers => true) do |row|
      Application.create(row.to_hash.slice(*%w[townname state_id]))
    end
  end
end




# CSV.foreach(filename, headers: true) do |row|
#   town = Town.create!(townname: row["townname"], state_id: row["state_id"])
# end


# csv.each do |row|
#   puts row.to_hash
# end
# puts csv_text
