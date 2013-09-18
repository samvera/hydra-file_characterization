require 'open3'

module Hydra::FileCharacterization
  class ToTempFile
    include Open3

    attr_accessor :data, :filename

    def initialize(data, filename)
      @data = data
      @filename = filename
    end

    def call
      return unless data.empty?
      timestamp = DateTime.now.strftime("%Y%m%d%M%S")
      Tempfile.open("#{timestamp}_#{File.basename(filename)}") do |f|
        f.binmode
        f.write(data)
        f.rewind
        yield(f)
      end
    end
  end
end
