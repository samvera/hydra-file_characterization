require 'spec_helper'

describe Hydra::FileCharacterization do

  #Given I have a File on the file system
  #When I call FileCharacterization with the path to the File
  #Then I get a raw XML string

  describe 'characterize file' do
    subject do
      @file = File.open(File.join(File.dirname(__FILE__), '..', 'fixtures', "brendan_behan.jpeg"))
    end 
    it "returns an XML metadata string for a valid file" do
      output = double('output')
      meta_data_xml = Characterizer.characterize(subject)
    end
  end 

end
