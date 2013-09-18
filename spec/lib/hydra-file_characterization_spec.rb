require 'spec_helper'
require 'hydra-file_characterization'

describe Hydra::FileCharacterization do

  describe 'ToTempFile' do
    subject { Hydra::FileCharacterization::ToTempFile.new(string, "hello.rb") }

    xit 'create a tempfile that exists' do
      @tempfile = nil
      subject.call do |temp_file|
        @temp_file = temp_file
        expect(File.exist?(@temp_file)).to eq true
        expect(File.extname(@temp_file)).to eq '.rb'
      end
      expect(File.exist?(@temp_file)).to eq false
    end
  end

end
