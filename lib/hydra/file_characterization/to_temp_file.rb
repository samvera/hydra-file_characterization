require 'open3'
require 'tempfile'

module Hydra::FileCharacterization
  class ToTempFile
    include Open3

    def self.open(*args, &block)
      new(*args).call(&block)
    end

    attr_reader :data, :filename

    def initialize(data, filename)
      self.data = data
      @filename = filename
    end

    def call
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

    protected

    def data=(value)
      @data = value.respond_to?(:read) ? value.read : value
    end
  end
end
