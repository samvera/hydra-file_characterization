require 'spec_helper'
require 'hydra/file_characterization/characterizer'

module Hydra::FileCharacterization
  describe Characterizer do
    let(:filename) { __FILE__ }
    let(:instance_tool_path) { nil }
    let(:class_tool_path) { nil }

    subject { Hydra::FileCharacterization::Characterizer.new(filename, instance_tool_path) }
    around(:each) do |example|
      Hydra::FileCharacterization::Characterizer.tool_path = class_tool_path
      example.run
      Hydra::FileCharacterization::Characterizer.tool_path = nil
    end

    context 'with custom instance tool_path' do
      let(:instance_tool_path) { '/arbitrary/path' }
      let(:class_tool_path) { '/a_different/path' }

      its(:tool_path) { should eq instance_tool_path}
    end

    context 'with custom class tool_path' do
      let(:instance_tool_path) { nil }
      let(:class_tool_path) { '/a_different/path' }

      its(:tool_path) { should eq class_tool_path}
    end

    context 'without a specified tool_path' do
      it 'should raise Hydra::FileCharacterization::UnspecifiedToolPathError' do
        expect {
          subject.tool_path
        }.to raise_error(Hydra::FileCharacterization::UnspecifiedToolPathError)
      end
    end
  end
end