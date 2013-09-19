require 'spec_helper'
require 'hydra/file_characterization/characterizers'

module Hydra::FileCharacterization
  describe Characterizers do
    subject { Hydra::FileCharacterization.characterizer(tool_name) }

    describe 'with :fits tool_name' do
      let(:tool_name) { :fits }
      it { should eq(Characterizers::Fits) }
    end

  end
end
