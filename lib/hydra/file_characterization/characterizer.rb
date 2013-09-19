require 'hydra/file_characterization/exceptions'
require 'open3'

module Hydra::FileCharacterization
  class Characterizer
    include Open3

    attr_reader :filename, :tool_path
    def initialize(filename, tool_path)
      @filename = filename
      @tool_path = tool_path
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
  end
end
