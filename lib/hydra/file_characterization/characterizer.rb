require 'hydra/file_characterization/exceptions'
require 'open3'
require 'active_support/core_ext/class/attribute'

module Hydra::FileCharacterization
  class Characterizer
    include Open3

    class_attribute :tool_path

    attr_reader :filename
    def initialize(filename)
      @filename = filename
    end

    def call
      unless File.exists?(filename)
        raise Hydra::FileCharacterization::FileNotFoundError.new("File: #{filename} does not exist.")
      end
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

    protected

    def command
      raise NotImplementedError, "Method #command should be overriden in child classes"
    end

    def tool_path
      raise NotImplementedError, "Method #tool_path should be overriden in child classes"
    end
  end
end
