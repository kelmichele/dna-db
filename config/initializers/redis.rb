$redis = Redis.new(url: ENV["REDISTOGO_URL"]) if Rails.env.production?
