require "hydra/file_characterization/version"
require "hydra/file_characterization/exceptions"
require "hydra/file_characterization/to_temp_file"
require "hydra/file_characterization/characterizer"
require "hydra/file_characterization/characterizers"
require "active_support/configurable"

module Hydra

  module_function

  # A convenience method
  def characterize(*args, &block)
    FileCharacterization.characterize(*args, &block)
  end

  module FileCharacterization

    class << self
      attr_accessor :configuration
    end

    #
    # Run all of the specified tools against the given content and filename.
    #
    # @example
    #   xml_string = Hydra::FileCharacterization.characterize(contents_of_a_file, 'file.rb', :fits)
    #
    # @example
    #   xml_string = Hydra::FileCharacterization.characterize(contents_of_a_file, 'file.rb', :fits) do |config|
    #     config[:fits] = './really/custom/path/to/fits'
    #   end
    #
    # @example
    #   fits_xml, ffprobe_xml = Hydra::FileCharacterization.characterize(contents_of_a_file, 'file.rb', :fits, :ffprobe)
    #
    # @param [String] content - The contents of the original file
    # @param [String] filename - The original file's filename; Some
    #   characterization tools take hints from the file names
    # @param [Hash/Array] tool_names - A list of tool names available on the system
    #   if you provide a Hash
    #
    # @return [String, Array<String>] -
    #    String - When a single tool_name is given, returns the raw XML as a
    #      string
    #    Array<String> - When multiple tool_names are given, returns an equal
    #      length Array of XML strings
    #
    # @yieldparam [Hash] For any of the specified tool_names, if you add a
    #    key to the yieldparam with a value, that value will be used as the path
    #
    # @see Hydra::FileCharacterization.configure
    def self.characterize(content, filename, *tool_names)
      tool_outputs = []
      tool_names = Array(tool_names).flatten.compact
      custom_paths = {}
      yield(custom_paths) if block_given?
      FileCharacterization::ToTempFile.open(content, filename) do |f|
        tool_names.each do |tool_name|
          tool_outputs << FileCharacterization.characterize_with(tool_name, f.path, custom_paths[tool_name])
        end
      end
      tool_names.size == 1 ? tool_outputs.first : tool_outputs
    end

    def self.configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end

    class Configuration
      def tool_path(tool_name, tool_path)
        Hydra::FileCharacterization.characterizer(tool_name).tool_path = tool_path
      end
    end

  end
end