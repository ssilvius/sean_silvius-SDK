# frozen_string_literal: true

require "httparty"
require_relative "the_one_api/version"

# An SDK for https://the-one-api.dev movie endpoint.
module TheOneApi
  include HTTParty

  # Set the base URI for the API requests.
  base_uri "https://the-one-api.dev/v2/"
  format :json

  class << self
    attr_accessor :api_key, :opts
    attr_reader :film, :endpoint

    VALID_ENDPOINTS = %w[movie quote].freeze

    # configure the module at runtime or from settings.
    # API Key must come from ENV, not configurable at runtime
    def configure
      self.api_key = ENV["THE_ONE_API_KEY"]
      self.opts = {}
      yield(opts)
    end

    # Send an HTTP GET request to the specified endpoint with the API key.
    #
    # @param endpoint [Symbol] The endpoint to retrieve data from. Defaults to movie.
    # @param opts [Hash] Optional parameters to pass with the request for pagination or specific film.
    # @return [Hash, Array] The parsed JSON response.
    # @raise [RuntimeError] If the HTTP request fails.
    #
    def call(endpoint = :movie, options:) # rubocop:disable Metrics/AbcSize
      raise ArgumentError, "Invalid endpoint: #{endpoint}" unless VALID_ENDPOINTS.include?(endpoint.to_s)

      @endpoint = endpoint
      @film = options[:film]
      path = create_url

      opts[:limit] = options[:limit] if options[:limit]
      opts[:page]  = options[:page] if options[:page]
      opts[:offset] = options[:offset] if options[:offset]

      headers = { "Authorization" => "Bearer #{api_key}", "Content-Type" => "application/json" }

      response = HTTParty.get(path, headers: headers, query: opts)
      raise "Error retrieving data: #{response.code} #{response.message}" unless response.success?

      JSON.parse(response.body)
    end

    private

    # Under normal circumstances this would not be so, basic as it should use an allow list for known
    # endpoints not just the movie endpoint. Written very succinct to show this limit.
    def create_url
      case endpoint
      when :movie
        "#{base_uri}movie/#{film}"
      when :quote
        "#{base_uri}movie/#{film}/quote"
      end
    end
  end
end
