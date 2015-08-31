require 'spec_helper'
require 'hydra/file_characterization/characterizers/fits'

module Hydra::FileCharacterization::Characterizers
  describe Fits do
    let(:fits) { Fits.new(filename) }

    describe "#call" do
      subject { fits.call }

      context 'validfile' do
        let(:filename) { fixture_file('brendan_behan.jpeg') }
        it { is_expected.to include(%(<identity format="JPEG File Interchange Format" mimetype="image/jpeg")) }
      end

      context 'invalidFile' do
        let(:filename) { fixture_file('nofile.pdf') }
        it "raises an error" do
          expect { subject }.to raise_error(Hydra::FileCharacterization::FileNotFoundError)
        end
      end

      context 'corruptFile' do
        let(:filename) { fixture_file('brendan_broken.dxxd') }
        it { is_expected.to include(%(<identity format="Unknown Binary" mimetype="application/octet-stream")) }
      end

      context 'zip file should be characterized not its contents' do
        let(:filename) { fixture_file('archive.zip') }
        it { is_expected.to include(%(<identity format="ZIP Format" mimetype="application/zip"))}
      end
    end
  end
end
