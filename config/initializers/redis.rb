# frozen_string_literal: true

uri = URI.parse(ENV['REDISTOGO_URL'])
REDIS = Redis.new(host: uri.host, port: uri.port, password: uri.password)
Resque.redis = REDIS
