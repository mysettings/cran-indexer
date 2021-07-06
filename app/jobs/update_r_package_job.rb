# frozen_string_literal: true

require 'open-uri'
require 'zipper'
require 'downloader'
require 'cran/description_parser'

class UpdateRPackageJob < ApplicationJob
  queue_as :package_update

  def perform(r_package_id, dir_path = 'tmp/files')
    @r_package = RPackage.find(r_package_id)
    downloader.download(
      "http://cran.r-project.org/src/contrib/#{@r_package.name}_#{@r_package.version}.tar.gz",
      "#{dir_path}/#{@r_package.name}_#{@r_package.version}.tar.gz"
    )
    zipper.unzip(dir_path, @r_package.name, @r_package.version) do
      package_description = Cran::DescriptionParser.new(
        File.read("#{dir_path}/#{@r_package.name}/DESCRIPTION")
      )
      @r_package.update!(
        published_at: package_description.published_at,
        title: package_description.title,
        description: package_description.description,
        authors: package_description.authors,
        maintainers: package_description.maintainers
      )
    end
  end

  private

  def downloader
    @downloader ||= Downloader.new
  end

  def zipper
    @zipper ||= Zipper.new
  end
end
