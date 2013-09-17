# hydra-file_chracterization

Hydra::FileCharacterization as (extracted from Sufia and Hydra::Derivatives)

## Purpose

To provide a wrapper for file characterization

## To Consider

How others are using the extract_metadata method
- https://github.com/curationexperts/bawstun/blob/ff8142ac043604c11a6f57b03629284bfd3043ea/app/models/generic_file.rb#L173

## Todo Steps

- ~~Given a filename, characterize the file and return a raw XML stream~~
- Provide method for converting a StringIO and original file name to a temp file with comparable, then running the characterizer against the tempfile
- Provide a configuration option for the fits path; This would be the default for the characterizer
- Update existing Sufia implementation
  - Deprecrate Hydra::Derivatives direct method call
  - Instead call the characterizer with the content
- Allow characterization services to be chained together
  - This would involve renaming the Characterizer to something else (i.e. Characterizers::Fits)
- Provide an ActiveFedora Datastream that maps the raw XML stream to a datastructure

