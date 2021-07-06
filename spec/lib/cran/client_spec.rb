# frozen_string_literal: true

require 'rails_helper'
require 'cran/client'

RSpec.describe Cran::Client do
  describe '.packages' do
    context 'fetch successfully' do
      before do
        stub_request(:get, 'https://cran.r-project.org/src/contrib/PACKAGES').
          with(
            headers: {
              'Accept': '*/*',
              'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent': 'Ruby'
            }).
          to_return(
            status: 200,
            body: %{
Package: A3
Version: 1.0.0
Depends: R (>= 2.15.0), xtable, pbapply
Suggests: randomForest, e1071
License: GPL (>= 2)
MD5sum: 027ebdd8affce8f0effaecfcd5f5ade2
NeedsCompilation: no

Package: aaSEA
Version: 1.1.0
Depends: R(>= 3.4.0)
Imports: DT(>= 0.4), networkD3(>= 0.4), shiny(>= 1.0.5),
        shinydashboard(>= 0.7.0), magrittr(>= 1.5), Bios2cor(>= 2.0),
        seqinr(>= 3.4-5), plotly(>= 4.7.1), Hmisc(>= 4.1-1)
Suggests: knitr, rmarkdown
License: GPL-3
MD5sum: 0f9aaefc1f1cf18b6167f85dab3180d8
NeedsCompilation: no
            },
            headers: {}
          )
      end

      it 'returns a stream of packages' do
        stream = described_class.packages
        packages = []
        stream.each do |package|
          packages << package
        end
        expect(packages.length).to eq(2)
        expect(packages[0].name).to eq('A3')
        expect(packages[0].version).to eq('1.0.0')
        expect(packages[1].name).to eq('aaSEA')
        expect(packages[1].version).to eq('1.1.0')
      end
    end

    context 'fetch failed' do
      before do
        stub_request(:get, 'https://cran.r-project.org/src/contrib/PACKAGES').
        with(
          headers: {
            'Accept': '*/*',
            'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent': 'Ruby'
          }).
        to_return(status: 401, body: 'Unauthenticated', headers: {})
      end

      it 'raises an exception' do
        expect do
          described_class.packages
        end.to raise_error(Cran::FetchError)
      end
    end
  end
end
