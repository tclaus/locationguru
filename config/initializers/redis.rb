
REDIS = Redis.new(url: ENV["REDIS_URL"])
logger.info "Use redis from #{ENV['REDISTOGO_URL']}"
Resque.redis = REDIS
