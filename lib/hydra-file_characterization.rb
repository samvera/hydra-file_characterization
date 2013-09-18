require "hydra-file_characterization/version"
require "hydra-file_characterization/characterizer"
require "active_support/configurable"

module Hydra
  module FileCharacterization

    class Configuration
      include ActiveSupport::Configurable
      config_accessor :fits_path
    end
  end
end

