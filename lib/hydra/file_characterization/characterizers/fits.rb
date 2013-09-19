require 'hydra/file_characterization/characterizer'
module Hydra::FileCharacterization::Characterizers
  class Fits < Hydra::FileCharacterization::Characterizer

    protected
    def command
      "#{tool_path} -i \"#{filename}\""
    end

    def tool_path
      `which fits || which fits.sh`.strip
    end
  end
end
