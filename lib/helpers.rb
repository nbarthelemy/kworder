# encoding: UTF-8

module Kworder
  module Helpers

    def cache(key, ttl = settings.long_ttl, &block)
      return block.call(key) unless settings.enable_cache
      if settings.cache.get(key) == nil
        settings.cache.set(key, block.call(key), ttl + rand(100))
      end
      return settings.cache.get(key)
    end

    # varnish
    def cache_for(mins = 1)
      if settings.environment != :development
        response['Cache-Control'] = "public, max-age=#{60*mins}"
      end
    end

  end
end