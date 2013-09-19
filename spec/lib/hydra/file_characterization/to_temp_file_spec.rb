require 'spec_helper'
require 'hydra/file_characterization/to_temp_file'

module Hydra::FileCharacterization

  describe 'ToTempFile' do

    let(:content) { "This is the content of the file." }
    let(:filename) { "hello.rb" }

    describe '.open' do
      subject { ToTempFile }
      it 'creates a tempfile then unlinks it' do
        subject.open(content, filename) do |temp_file|
          @temp_file = temp_file
          expect(File.exist?(@temp_file.path)).to eq true
          expect(File.extname(@temp_file.path)).to include '.rb'
        end
        expect(@temp_file.path).to eq nil
      end
    end

    describe 'instance' do
      subject { ToTempFile.new(content, filename) }
      it 'create a tempfile that exists' do
        subject.call do |temp_file|
          @temp_file = temp_file
          expect(File.exist?(@temp_file.path)).to eq true
          expect(File.extname(@temp_file.path)).to include '.rb'
        end
        expect(@temp_file.path).to eq nil
      end
    end

  end
end
