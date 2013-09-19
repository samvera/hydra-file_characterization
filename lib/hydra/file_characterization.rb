require "hydra/file_characterization/version"
require "hydra/file_characterization/exceptions"
require "hydra/file_characterization/to_temp_file"
require "hydra/file_characterization/characterizer"
require "hydra/file_characterization/characterizers"
require "active_support/configurable"

module Hydra

  module_function

  #
  # Run all of the specified tools against the given content and filename.
  #
  # @param [String] content - The contents of the original file
  # @param [String] filename - The original file's filename; Some
  #   characterization tools take hints from the file names
  # @param [Array] tool_names - A list of tool names available on the system
  #
  # @return [String, Array<String>] -
  #    String - When a single tool_name is given, returns the raw XML as a
  #      string
  #    Array<String> - When multiple tool_names are given, returns an equal
  #      length Array of XML strings
  def characterize(content, filename, *tool_names)
    tool_outputs = []
    tool_names = Array(tool_names).flatten.compact
    FileCharacterization::ToTempFile.open(content, filename) do |f|
      tool_names.each do |tool_name|
        tool_outputs << FileCharacterization.characterize_with(tool_name, f.path)
      end
    end
    tool_names.size == 1 ? tool_outputs.first : tool_outputs
  end

  module FileCharacterization

    class Configuration
      def configure
        yield(self)
      end

      def tool_path(tool_name, tool_path)
        Hydra::FileCharacterization.characterizer(tool_name).tool_path = tool_path
      end
    end

    module_function
    def configuration
      @configuration ||= Configuration.new
    end

    def configure(&block)
      configuration.configure(&block)
    end
  end
end
