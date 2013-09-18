require 'spec_helper'
require 'hydra-file_characterization/to_temp_file'

describe Hydra::FileCharacterization do

  describe 'ToTempFile' do
    let(:string) { "This is the content of the file." }
    subject { Hydra::FileCharacterization::ToTempFile.new(string, "hello.rb") }

    it 'create a tempfile that exists' do
      @temp_file = ''
      subject.call do |temp_file|
        @temp_file = temp_file
        expect(File.exist?(@temp_file)).to eq true
        expect(File.extname(@temp_file)).to eq '.rb'
      end
      expect(File.exist?(@temp_file)).to eq false
    end
  end
end
