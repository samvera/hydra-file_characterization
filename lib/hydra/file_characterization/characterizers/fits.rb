require 'hydra/file_characterization/characterizer'
module Hydra::FileCharacterization::Characterizers
  class Fits < Hydra::FileCharacterization::Characterizer
    protected
    def command
      "#{tool_path} -i \"#{filename}\""
    end
  end
end
