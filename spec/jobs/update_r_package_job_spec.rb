# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateRPackageJob, type: :job do
  describe '#perform' do
    let(:name) { "package_1" }
    let(:version) { '0.1.5' }
    let(:r_package) { FactoryBot.create(:r_package, name: name, version: version) }
    let(:downloader) { double(:downloader) }

    class FakeZipper
      def unzip(path, name, version)
        `mkdir #{path}/#{name}`
        `cp spec/fixtures/DESCRIPTION #{path}/#{name}/`
        yield if block_given?
        `rm -rf #{path}/#{name}`
      end
    end

    it 'updates the information of the package' do
      expect(Downloader).to receive(:new).and_return(downloader)
      expect(downloader).to receive(:download)

      zipper = FakeZipper.new
      expect(Zipper).to receive(:new).and_return(zipper)

      described_class.new.perform(r_package.id, 'spec/jobs')
      expect(r_package.reload.title).to eq('Analytical Tools for Zooarchaeological Data')
      expect(r_package.published_at).to eq('2016-01-30 10:05:04'.to_time)
      expect(r_package.description).to eq('The analysis and inference of faunal remains recovered from archaeological sites concerns the field of zooarchaeology. The zooaRch package provides analytical tools to make inferences on zooarchaeological data. Functions in this package allow users to read, manipulate, visualize, and analyze zooarchaeological data.')
      expect(r_package.authors).to eq(['Erik Otarola-Castillo', 'Jesse Wolfhagen', 'Max D. Price'])
      expect(r_package.maintainers).to eq(['Erik Otarola-Castillo <eotarolacastillo@fas.harvard.edu>'])
    end
  end
end
