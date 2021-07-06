# frozen_string_literal: true

require 'cran/package'

module Cran
  class PackageStream
    PACKAGE_PREFIX = 'Package: '
    VERSION_PREFIX = 'Version: '

    # MAX_PACKAGES limits the number of packages fetched.
    MAX_PACKAGES = 200

    attr_reader :data_stream

    def initialize(data)
      @data_stream = StringIO.new(data)
    end

    def each(&block)
      count = 0
      while true do
        s = data_stream.gets
        if s.start_with?(PACKAGE_PREFIX)
          name = s.split(PACKAGE_PREFIX).last.strip
          version = data_stream.gets.split(VERSION_PREFIX).last.strip
          block.call(Package.new(name, version))
          count += 1
        end
        return if data_stream.eof? || count >= MAX_PACKAGES
      end
    end
  end
end
