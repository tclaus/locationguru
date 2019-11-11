# frozen_string_literal: true

uri = URI.parse(ENV['REDISTOGO_URL'])
Redis.current = Redis.new(host: uri.host, port: uri.port, password: uri.password)
Resque.redis = Redis.current
