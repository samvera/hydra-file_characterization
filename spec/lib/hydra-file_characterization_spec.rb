require 'spec_helper'

describe Hydra::FileCharacterization do

  Given I have a File on the file system
  When I call FileCharacterization with the path to the File
  Then I get a raw XML string

end
