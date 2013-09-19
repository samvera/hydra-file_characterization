require 'spec_helper'
require 'hydra/file_characterization/characterizers/fits'

module Hydra::FileCharacterization::Characterizers

  describe Fits do

    subject { Fits.new(filename, fits_path) }
    let(:fits_path) { `which fits || which fits.sh`.strip }

    describe 'validfile' do
      let(:filename) { fixture_file('brendan_behan.jpeg') }
      it '#call' do
        expect(subject.call).to include(%(<identity format="JPEG File Interchange Format" mimetype="image/jpeg"))
      end
    end

    describe 'invalidFile' do
      let(:filename) { fixture_file('nofile.pdf') }
      it "should raise an error if the path does not contain the file" do
        expect {subject.call}.to raise_error(Hydra::FileCharacterization::FileNotFoundError)
      end
    end

    describe 'corruptFile' do
      let(:filename) { fixture_file('brendan_broken.dxxd') }
      it "should return xml showing Unknown Binary and application/octet-stream mimetype" do
        expect(subject.call).to include(%(<identity format="Unknown Binary" mimetype="application/octet-stream"))
      end
    end

    describe 'zip file should be characterized not its contents' do
      let(:filename) { fixture_file('archive.zip') }
      its(:call) { should include(%(<identity format="ZIP Format" mimetype="application/zip"))}
    end

  end

end
