require 'spec_helper'
require 'hydra/file_characterization/characterizers'

module Hydra::FileCharacterization
  describe Characterizers do
    subject { Hydra::FileCharacterization.characterizer(tool_name) }

    describe 'with :fits tool_name' do
      let(:tool_name) { :fits }
      it { should eq(Characterizers::Fits) }
    end

    describe 'with :ffprobe tool_name' do
      let(:tool_name) { :ffprobe }
      it { should eq(Characterizers::Ffprobe) }
    end

    context '.characterize_with' do
      let(:tool_name) { :fits }
      let(:filename) { __FILE__ }
      let(:tool_path) { nil }
      subject { Hydra::FileCharacterization.characterize_with(tool_name, filename, tool_path) }

      context 'with callable tool_path and missing tool name' do
        let(:tool_path) { lambda {|filename| [filename, :tool_path]} }
        let(:tool_name) { :chunky_salsa }
        it { should eq [filename, :tool_path] }
      end

      context 'with missing tool name and non-callable tool_path' do
        let(:tool_name) { :chunky_salsa }
        let(:tool_path) { '/path' }
        it 'should raise exception' do
          expect {
            subject
          }.to raise_error(ToolNotFoundError)
        end
      end
    end

  end
end