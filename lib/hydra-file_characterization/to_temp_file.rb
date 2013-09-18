require 'open3'
require 'tempfile'

module Hydra::FileCharacterization
  class ToTempFile
    include Open3

    attr_accessor :data, :filename

    def initialize(data, filename)
      @data = data
      @filename = filename
    end

    def call
      return if data.empty?
      f = Tempfile.new([File.basename(filename),File.extname(filename)])
      begin
        f.binmode
        f.write(data)
        f.rewind
        yield(f)
      ensure
        f.close
        f.unlink
      end

    end
  end
end
