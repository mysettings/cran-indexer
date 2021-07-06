# frozen_string_literal: true

require 'cran/package_stream'

module Cran
  class Error < StandardError; end
  class FetchError < Error; end

  class Client
    CRAN_BASE_URI = 'https://cran.r-project.org'

    include HTTParty
    base_uri CRAN_BASE_URI

    def self.packages
      resp = get('/src/contrib/PACKAGES')
      raise FetchError.new(resp.body) unless resp.success?
      PackageStream.new(resp.body)
    end
  end
end
