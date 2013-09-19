require 'spec_helper'
require 'hydra/file_characterization'
require 'hydra/file_characterization/characterizer'

module Hydra

  describe '.characterize' do
    let(:content) { "class Test; end\n" }
    let(:filename) { 'test.rb' }
    subject { Hydra.characterize(content, filename, tool_names) }

    describe 'for fits' do
      let(:tool_names) { :fits }
      it { should match(/#{'<identity format="Plain text" mimetype="text/plain"'}/) }
    end

    describe 'for a bogus tool' do
      let(:tool_names) { :cookie_monster }
      it {
        expect {
          subject
        }.to raise_error(Hydra::FileCharacterization::ToolNotFoundError)
      }
    end

    describe 'for a mix of bogus and valid tools' do
      let(:tool_names) { [:fits, :cookie_monster] }
      it {
        expect {
          subject
        }.to raise_error(Hydra::FileCharacterization::ToolNotFoundError)
      }
    end

    describe 'for no tools' do
      let(:tool_names) { nil }
      it { should eq [] }
    end

  end

  module FileCharacterization

    describe Configuration do
      subject { Configuration.new }
      let (:expected_fits_path) {"string"}
      before(:each) do
        subject.tool_path = expected_fits_path
      end
      its(:config) {should have_key :tool_path}
      its(:tool_path) {should == expected_fits_path}
    end

    describe 'preliminary integration' do
      let (:tempfile) { ToTempFile.new("This is the content of the file.", 'test.rb')}
      it '#call' do
        tempfile.call do |f|
          @fits_output = Characterizers::Fits.new(f.path ).call
        end
        expect(@fits_output).to include '<identity format="Plain text" mimetype="text/plain"'
      end
    end

  end
end
