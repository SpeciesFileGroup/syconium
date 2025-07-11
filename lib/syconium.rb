# frozen_string_literal: true
require "erb"
require_relative "syconium/error"
require_relative "syconium/version"
require_relative "syconium/request"
require "syconium/helpers/configuration"

# The Syconium module provides a Ruby interface to the BHL Names API
module Syconium
  extend Configuration

  define_setting :base_url, "https://api.openalex.org/"
  define_setting :mailto, ENV["SYCONIUM_API_EMAIL"]

  # Gets a resource from OpenAlex
  # @param autocomplete [Boolean] If true, suggests resources based on the search string
  # @param id [String] A resource ID (e.g., "W123456789", "doi:10.1234/abcd")
  # @param filter [String] A string of filters to apply to the request
  # @param group_by [String] If set will return a count of resources grouped by the specified field
  # @param q [String] The autocomplete query string (use the search parameter instead for searching resources)
  # @param random [Boolean] If true, returns a random resource
  # @param sample [Integer] If set, returns a random sample of resources
  # @param search [String] A search string to filter resources by (use the q parameter instead for autocomplete)
  # @param select [String] A string of fields to select in the response
  # @param sort [String] A string of fields to sort the results by (e.g., publication_year:desc,relevance_score:desc)
  # @param cursor [String] A cursor for pagination
  # @param page [Integer] The results list page number to retrieve
  # @param per_page [Integer] The number of results to return per page
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Hash] A result hash
  ENDPOINTS = %w[
    authors concepts funders institutions keywords publishers sources topics works  
  ]

  ENDPOINTS.each do |endpoint_name|
    define_singleton_method(endpoint_name) do |email: nil, api_key: nil, autocomplete: false, q: nil, id: nil, search: nil, filter: nil, group_by: nil, random: false, sample: nil, select: nil, sort: nil, cursor: nil, page: 1, per_page: 25, verbose: false|
      raise ArgumentError, "You must provide an email or API key to use the OpenAlex API" if email.nil? && api_key.nil? 
      params = {
        api_key: api_key,
        mailto: email,
        filter: filter,
        group_by: group_by,
        q: q,
        sample: sample,
        search: search,
        select: select,
        sort: sort,
        cursor: cursor,
        page: page,
        per_page: per_page,
      }.compact
      endpoint = endpoint_name
      if random
        endpoint += "/random"
        params = {}
      elsif id
        endpoint += "/#{id}"
        params = {}
      elsif autocomplete
        params = { q: q, filter: filter, search: search }.compact
        endpoint = "/autocomplete/#{endpoint_name}"
      end
      Request.new(endpoint: endpoint, params: params, verbose: verbose).perform
    end
  end
end
