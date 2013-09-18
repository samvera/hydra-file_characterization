require "hydra/file_characterization/version"
require "hydra/file_characterization/characterizers"
require "hydra/file_characterization/to_temp_file"
require "active_support/configurable"

module Hydra
  module FileCharacterization

    class Configuration
      include ActiveSupport::Configurable
      config_accessor :fits_path
    end
  end
end

