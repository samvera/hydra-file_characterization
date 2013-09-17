require "hydra-file_characterization/version"
require 'open3'

module Hydra
  module FileCharacterization
    class Characterizer
      include Open3

      class FileNotFoundError < RuntimeError
      end

      attr_reader :filename, :fits_path
      def initialize(filename, fits_path)
        @filename = filename
        @fits_path = fits_path
      end

      def call
        unless File.exists?(filename)
          raise FileNotFoundError.new("File: #{filename} does not exist.")
        end
        command = "#{fits_path} -i \"#{filename}\""
        stdin, stdout, stderr, wait_thr = popen3(command)
        begin
          out = stdout.read
          err = stderr.read
          exit_status = wait_thr.value
          raise "Unable to execute command \"#{command}\"\n#{err}" unless exit_status.success?
          out
        ensure
          stdin.close
          stdout.close
          stderr.close
        end
      end
    end
  end
end

