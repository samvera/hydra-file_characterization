require 'spec_helper'
require 'hydra-file_characterization'

describe Hydra::FileCharacterization::Characterizer do
  def fixture_file(filename)
    File.expand_path(File.join('../../fixtures', filename), __FILE__)
  end

  let(:fits_path) { `which fits || which fits.sh`.strip }
  subject { Hydra::FileCharacterization::Characterizer.new(filename, fits_path) }

  describe 'validfile' do
    let(:filename) { fixture_file('brendan_behan.jpeg') }
    it '#call' do
      expect(subject.call).to include(%(<identity format="JPEG File Interchange Format" mimetype="image/jpeg"))
    end

  end

  describe 'invalidFile' do
    let(:filename) { fixture_file('nofile.pdf') }
    it "should raise an error if the path does not contain the file" do

      expect {subject.call}.to raise_error(RuntimeError)
    end
  end


  describe 'corruptFile' do
    let(:filename) { fixture_file('brendan_broken.dxxd') }
    it "should return xml showing Unknown Binary and application/octet-stream mimetype" do
      expect(subject.call).to include(%(<identity format="Unknown Binary" mimetype="application/octet-stream"))
    end
  end
end
