# frozen_string_literal: true

class Downloader
  def download(remote_url, file_path)
    open(file_path, 'wb') do |file|
      file << URI.open(remote_url).read
    end
  end
end
