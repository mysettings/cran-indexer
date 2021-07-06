# frozen_string_literal: true

module Cran
  class DescriptionParser
    attr_reader :data

    def initialize(data)
      @data = data.gsub(/\n\s+/, "\s")
    end

    def published_at
      data[/Date\/Publication: ([^\n]+)/, 1].to_time
    end

    def title
      data[/Title: ([^\n]+)/, 1]
    end

    def description
      data[/Description: ([^\n]+)/, 1]
    end

    def authors
      data[/Author.*: ([^\n]+)/, 1].split(',').map(&:strip)
    end

    def maintainers
      data[/Maintainer.*: ([^\n]+)/, 1].split(',').map(&:strip)
    end
  end
end
