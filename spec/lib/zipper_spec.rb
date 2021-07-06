# frozen_string_literal: true

require 'rails_helper'
require 'zipper'

RSpec.describe Zipper do
  describe '.unzip' do
    let(:zipper) { described_class.new }

    it 'unzips and removes the files' do
      `cp spec/fixtures/zooaRch_1.2.tar.gz spec/lib`
      expect(File.file?('spec/lib/zooaRch_1.2.tar.gz')).to eq(true)
      zipper.unzip('spec/lib', 'zooaRch', '1.2') do
        expect(File.directory?('spec/lib/zooaRch')).to eq(true)
        expect(File.file?('spec/lib/zooaRch/DESCRIPTION')).to eq(true)
      end
      expect(File.directory?('spec/lib/zooaRch')).to eq(false)
      expect(File.file?('spec/lib/zooaRch_1.2.tar.gz')).to eq(false)
    end
  end
end
