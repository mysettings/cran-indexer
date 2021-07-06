# frozen_string_literal: true

class RPackage < ApplicationRecord
  after_create_commit :queue_for_update

  private

  def queue_for_update
    UpdateRPackageJob.perform_later(id)
  end
end
