module Teamcity
  class Client
    attr_reader :client
    protected :client

    def initialize url
      @client = RestClient::Resource.new url, 'admin', '11111'
    end

    def build(params, filter = {})
      JSON.parse client["builds/#{join_params(params)}#{join_filters(filter)}"].get accept: :json
    rescue => e
    end

    def commiters(changes_href)
      changes = changes(changes_href[/changes.*/])
      Array(changes['change']).map do |c|
        change(c['href'][/changes.*/])['username']
      end
    end

    def changes(href)
      JSON.parse client[href].get accept: :json
    end

    def change(href)
      JSON.parse client[href].get accept: :json
    end

    def builds
      json = JSON.parse client['builds'].get accept: :json

      json['build'].map do |build|
        Build.new(self, build).attributes
      end
    end

    def build_types
      JSON.parse(client['buildTypes'].get accept: :json)['buildType']
    end

    def build_type(id)
      @@build_type_cache ||= Hash.new { |memo, id| memo[id] = BuildType.new(client, id) }
      @@build_type_cache[id]
    end

    protected

    def join_params(hash)
      hash.map { |k, v| [k,v].join(':')  }.join('/')
    end

    def join_filters(filters)
      filter = filters.map { |k, v| [k,v].join('=')  }.join('&')
      filter ? "?" << filter : ''
    end
  end
end
