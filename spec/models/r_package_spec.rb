# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RPackage, type: :model do
  describe 'callbacks' do
    describe 'queue_for_update' do
      it 'invokes UpdateRPackageJob' do
        package = FactoryBot.build(:r_package)
        expect(UpdateRPackageJob).to receive(:perform_later)
        package.save
      end
    end
  end
end
