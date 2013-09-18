module Hydra::FileCharacterization::Characterizers
  class FileNotFoundError < RuntimeError
  end
end

require 'hydra-file_characterization/characterizers/fits'
