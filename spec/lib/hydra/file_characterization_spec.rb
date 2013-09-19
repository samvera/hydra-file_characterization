require 'spec_helper'
require 'hydra/file_characterization'

module Hydra::FileCharacterization

  describe Configuration do
    subject { Configuration.new }
    let (:expected_fits_path) {"string"}
    before(:each) do
      subject.fits_path = expected_fits_path
    end
    its(:config) {should have_key :fits_path}
    its(:fits_path) {should == expected_fits_path}
  end

  describe 'preliminary integration' do
    let (:tempfile) { ToTempFile.new("This is the content of the file.", 'test.rb')}
    let(:fits_path) { `which fits || which fits.sh`.strip }
    it '#call' do
      tempfile.call do |f|
        @fits_output = Characterizers::Fits.new(f.path,fits_path ).call
      end
      expect(@fits_output).to include '<identity format="Plain text" mimetype="text/plain"'
    end
  end

end
