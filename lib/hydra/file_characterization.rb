require "hydra/file_characterization/version"
require "hydra/file_characterization/exceptions"
require "hydra/file_characterization/to_temp_file"
require "hydra/file_characterization/characterizer"
require "hydra/file_characterization/characterizers"
require "active_support/configurable"

module Hydra

  module_function
  def characterize(content, filename, *options)
    tool_outputs = []
    tool_names = Array(options).flatten.compact
    FileCharacterization::ToTempFile.open(content, filename) do |f|
      tool_names.each do |tool_name|
        tool_outputs << FileCharacterization.characterize_with(tool_name, f.path)
      end
    end
    tool_names.size == 1 ? tool_outputs.first : tool_outputs
  end

  module FileCharacterization

    class Configuration
      include ActiveSupport::Configurable
      config_accessor :tool_path
    end
  end
end
