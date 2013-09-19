# hydra-file_chracterization

Hydra::FileCharacterization as (extracted from Sufia and Hydra::Derivatives)

## Purpose

To provide a wrapper for file characterization

## How To Use

If you are using Rails add the following to an initializer (./config/initializers/hydra-file_characterization_config.rb):

    Hydra::FileCharacterization.configure do |config|
      config.tool_path(:fits, '/path/to/fits')
    end

To use the characterizer:

    characterization_xml = Hydra.characterize(file.read, file.basename, :fits)

    # This does not work at this point
    fits_xml, ffprobe_xml  = Hydra.characterize(file.read, file.basename, :fits, :ffprobe)

* Why `file.read`? To highlight that we want a string. In the case of ActiveFedora, we have a StringIO instead of a file.
* Why `file.basename`? In the case of Fits, the characterization takes cues from the extension name.

## Registering New Characterizers

This is possible by adding a characterizer to the `Hydra::FileCharacterization::Characterizers`' namespace.

## To Consider

How others are using the extract_metadata method
- https://github.com/curationexperts/bawstun/blob/ff8142ac043604c11a6f57b03629284bfd3043ea/app/models/generic_file.rb#L173

## Todo Steps

- ~~Given a filename, characterize the file and return a raw XML stream~~
- ~~Provide method for converting a StringIO and original file name to a temp file with comparable, then running the characterizer against the tempfile~~
- ~~Provide a configuration option for the fits path; This would be the default for the characterizer~~
- ~~Allow characterization services to be chained together~~
  - ~~This would involve renaming the Characterizer to something else (i.e. Characterizers::Fits)~~
- Add tests that run against given pre-defined output of Fits and FFProbe (i.e. allow the output to more easily be mocked)
- Provide Hydra::FileCharacterization::SpecSupport that allows for easy overriding of characterization in applications that implement Hydra::FileCharacterization.
- Update existing Sufia implementation
  - Deprecrate Hydra::Derivatives direct method call
  - Instead call the characterizer with the content
- Provide an ActiveFedora Datastream that maps the raw XML stream to a datastructure
