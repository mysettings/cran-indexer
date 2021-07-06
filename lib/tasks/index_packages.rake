# frozen_string_literal: true

require 'cran/client'

desc "This task will be run at 12PM everyday to index the R packages"
task index_r_packages: :environment do
  Cran::Client.packages.each do |package|
    RPackage.find_or_create_by(
      name: package.name,
      version: package.version
    )
  end
end
