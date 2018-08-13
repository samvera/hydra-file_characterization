# hydra-file_chracterization
[![Version](https://badge.fury.io/rb/hydra-file_characterization.png)](http://badge.fury.io/rb/hydra-file_characterization)
[![Build Status](https://travis-ci.org/projecthydra/hydra-file_characterization.png?branch=master)](https://travis-ci.org/projecthydra/hydra-file_characterization)

Hydra::FileCharacterization as (extracted from Sufia and Hydra::Derivatives)

## Purpose

To provide a wrapper for file characterization

## How To Use

If you are using Rails add the following to an initializer (./config/initializers/hydra-file_characterization_config.rb):

```ruby
Hydra::FileCharacterization.configure do |config|
  config.tool_path(:fits, '/path/to/fits')
end
```
```ruby
Hydra::FileCharacterization.characterize(File.read(filename), File.basename(filename), :fits)```

* Why `file.read`? To highlight that we want a string. In the case of ActiveFedora, we have a StringIO instead of a file.
* Why `file.basename`? In the case of Fits, the characterization takes cues from the extension name.

You can call a single characterizer…

```ruby
xml_string = Hydra::FileCharacterization.characterize(File.read("/path/to/my/file.rb"), 'file.rb', :fits)
```

…for this particular call, you can specify custom fits path…

```ruby
xml_string = Hydra::FileCharacterization.characterize(contents_of_a_file, 'file.rb', :fits) do |config|
  config[:fits] = './really/custom/path/to/fits'
end
```

…or even make the path callable…

```ruby
xml_string = Hydra::FileCharacterization.characterize(contents_of_a_file, 'file.rb', :fits) do |config|
  config[:fits] = lambda {|filename| … }
end
```

…or even create your custom characterizer on the file…

```ruby
xml_string = Hydra::FileCharacterization.characterize(contents_of_a_file, 'file.rb', :my_characterizer) do |config|
  config[:my_characterizer] = lambda {|filename| … }
end
```

You can also call multiple characterizers at the same time.

```ruby
fits_xml, ffprobe_xml = Hydra::FileCharacterization.characterize(contents_of_a_file, 'file.rb', :fits, :ffprobe)
```

## Registering New Characterizers

This is possible by adding a characterizer to the `Hydra::FileCharacterization::Characterizers`' namespace.
