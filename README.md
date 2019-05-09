# hydra-file_characterization

Code: [![Version](https://badge.fury.io/rb/hydra-file_characterization.png)](http://badge.fury.io/rb/hydra-file_characterization)
[![CircleCI](https://circleci.com/gh/samvera/hydra-file_characterization.svg?style=svg)](https://circleci.com/gh/samvera/hydra-file_characterization)
[![Coverage Status](https://coveralls.io/repos/github/samvera/hydra-file_characterization/badge.svg?branch=master)](https://coveralls.io/github/samvera/hydra-file_characterization?branch=master)

Docs: [![Contribution Guidelines](http://img.shields.io/badge/CONTRIBUTING-Guidelines-blue.svg)](./CONTRIBUTING.md)
[![Apache 2.0 License](http://img.shields.io/badge/APACHE2-license-blue.svg)](./LICENSE)

Jump in: [![Slack Status](http://slack.samvera.org/badge.svg)](http://slack.samvera.org/)

# What is hydra-file_characterization?

Provides a wrapper for file characterization.

## Product Owner & Maintenance

hydra-file_characterization is a Core Component of the Samvera community. The documentation for
what this means can be found
[here](http://samvera.github.io/core_components.html#requirements-for-a-core-component).

### Product Owner

[little9](https://github.com/little9)

# Help

The Samvera community is here to help. Please see our [support guide](./SUPPORT.md).

# Getting Started

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

# Acknowledgments

This software has been developed by and is brought to you by the Samvera community.  Learn more at the
[Samvera website](http://samvera.org/).

![Samvera Logo](https://wiki.duraspace.org/download/thumbnails/87459292/samvera-fall-font2-200w.png?version=1&modificationDate=1498550535816&api=v2)
