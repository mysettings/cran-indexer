# frozen_string_literal: true

class Zipper
  def unzip(path, package, version)
    `tar -xf #{path}/#{package}_#{version}.tar.gz -C #{path}`
    yield if block_given?
    `rm -r #{path}/#{package}`
    `rm #{path}/#{package}_#{version}.tar.gz`
  end
end
