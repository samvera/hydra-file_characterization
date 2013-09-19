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

  describe FileCharacterization do

    describe '.configure' do
      let(:content) { "class Test; end\n" }
      let(:filename) { 'test.rb' }
      around do |example|
        old_tool_path = Hydra::FileCharacterization::Characterizers::Fits.tool_path
        example.run
        Hydra::FileCharacterization::Characterizers::Fits.tool_path = old_tool_path
      end

      it 'without configuration' do
        Hydra::FileCharacterization.configure do |config|
          config.tool_path(:fits, nil)
        end

        expect {
          Hydra.characterize(content, filename, :fits)
        }.to raise_error(Hydra::FileCharacterization::UnspecifiedToolPathError)
      end
    end

  end
end
