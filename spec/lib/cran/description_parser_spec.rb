# frozen_string_literal: true

require 'rails_helper'
require 'cran/description_parser'

RSpec.describe Cran::DescriptionParser do
  [
    {
      data: %{
Package: AEP
Type: Package
Title: Statistical Modelling for Asymmetric Exponential Power
        Distribution
Author: Mahdi Teimouri
Maintainer: Mahdi Teimouri <teimouri@aut.ac.ir>
Description: Developed for Computing the probability density function,
              cumulative distribution function, random generation, estimating the parameters
              of asymmetric exponential power distribution, and robust regression analysis
              with error term that follows asymmetric exponential power distribution.
Encoding: UTF-8
License: GPL (>= 2)
Depends: R(>= 3.3.0)
Repository: CRAN
Version: 0.1.2
Date: 2020-08-12
NeedsCompilation: no
Packaged: 2020-08-11 23:28:49 UTC; NikPardaz
Date/Publication: 2020-08-12 11:22:15 UTC
      },
      published_at: '2020-08-12 11:22:15 UTC',
      title: 'Statistical Modelling for Asymmetric Exponential Power Distribution',
      description: 'Developed for Computing the probability density function, cumulative distribution function, random generation, estimating the parameters of asymmetric exponential power distribution, and robust regression analysis with error term that follows asymmetric exponential power distribution.',
      authors: ['Mahdi Teimouri'],
      maintainers: ['Mahdi Teimouri <teimouri@aut.ac.ir>']
    }
  ].each do |test_case|
    context test_case[:data] do
      let(:parser) { described_class.new(test_case[:data]) }

      %i(published_at title description authors maintainers).each do |attr|
        describe "##{attr}" do
          it "returns #{test_case[attr]}" do
            expect(parser.send(attr)).to eq(test_case[attr])
          end
        end
      end
    end
  end
end
