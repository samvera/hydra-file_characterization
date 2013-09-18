require 'spec_helper'
require 'hydra-file_characterization'

describe Hydra::FileCharacterization do



  describe 'config' do
    subject { Hydra::FileCharacterization::Configuration.new }
    let (:expected_fits_path) {"string"}
    before(:each) do
      subject.fits_path = expected_fits_path
    end
    its(:config) {should have_key :fits_path}
    its(:fits_path) {should == expected_fits_path}
  end

end
