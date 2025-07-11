require_relative "faraday" # !! Potential ruby 3.0 difference in module loading? relative differs from Serrano
require "faraday/follow_redirects"
require_relative "utils"

module Syconium

  class Request
    attr_accessor :endpoint
    attr_accessor :q
    attr_accessor :verbose

    attr_accessor :options

    def initialize(**args)
      @endpoint = args[:endpoint]
      @email = args[:email]
      @verbose = args[:verbose]
      @params = args[:params]
      @options = args[:options] # TODO: not added at syconium.rb
    end

    def perform

      opts = @params&.compact || {}

      Faraday::Utils.default_space_encoding = "+"

      conn = if verbose
               Faraday.new(url: Syconium.base_url) do |f|
                 f.response :logger
                 f.use Faraday::SyconiumErrors::Middleware
                 f.adapter Faraday.default_adapter
               end
             else
               Faraday.new(url: Syconium.base_url) do |f|
                 f.use Faraday::SyconiumErrors::Middleware
                 f.adapter Faraday.default_adapter
               end
             end

      conn.headers['Accept'] = 'application/json,*/*'
      conn.headers[:user_agent] = make_user_agent
      conn.headers["X-USER-AGENT"] = make_user_agent
      conn.headers['Content-Type'] = 'application/json'

      res = conn.get(endpoint, opts)

      # The endpoints should all return JSON, but if they don't, we should still return the body
      begin
        MultiJson.load(res.body)
      rescue MultiJson::ParseError
        res.body
      end
      
    end
  end
end
