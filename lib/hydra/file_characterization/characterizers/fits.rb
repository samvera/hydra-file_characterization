require 'hydra/file_characterization/exceptions'
require 'hydra/file_characterization/characterizer'
module Hydra::FileCharacterization::Characterizers
  class Fits < Hydra::FileCharacterization::Characterizer

    protected
    def command
      "#{tool_path} -i \"#{filename}\""
    end

    def tool_path
      self.class.tool_path || (raise Hydra::FileCharacterization::UnspecifiedToolPathError.new(self.class))
    end
  end
end
