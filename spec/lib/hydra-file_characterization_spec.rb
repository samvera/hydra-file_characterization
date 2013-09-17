require 'spec_helper'
require 'hydra-file_characterization'

describe Hydra::FileCharacterization::Characterizer do
  def fixture_file(filename)
    File.expand_path(File.join('../../fixtures', filename), __FILE__)
  end

  let(:filename) { fixture_file('brendan_behan.jpeg') }
  let(:fits_path) { `which fits`.strip }
  subject { Hydra::FileCharacterization::Characterizer.new(filename, fits_path) }

  it '#call' do
    expect(subject.call).to include(%(<identity format="JPEG File Interchange Format" mimetype="image/jpeg"))
  end

end
