# hydra-file_chracterization

Hydra::FileCharacterization as (extracted from Sufia and Hydra::Derivatives)

## Purpose

To provide a wrapper for file characterization

## To Consider

How others are using the extract_metadata method
- https://github.com/curationexperts/bawstun/blob/ff8142ac043604c11a6f57b03629284bfd3043ea/app/models/generic_file.rb#L173

## Todo Steps

- Given a filename, characterize the file and return a raw XML stream
- Allow characterization services to be chained together
- Provide an ActiveFedora Datastream that maps the raw XML stream to a datastructure
