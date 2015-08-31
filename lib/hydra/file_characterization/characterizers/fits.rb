require 'hydra/file_characterization/exceptions'
require 'hydra/file_characterization/characterizer'
module Hydra::FileCharacterization::Characterizers
  class Fits < Hydra::FileCharacterization::Characterizer

    protected

      def command
        "#{tool_path} -i \"#{filename}\""
      end

      # Remove any residual non-XML from JHOVE
      # See: https://github.com/harvard-lts/fits/issues/20
      def post_process(raw_output)
        raw_output.sub(/^READBOX seen=true\n/, '')
      end
  end
end
