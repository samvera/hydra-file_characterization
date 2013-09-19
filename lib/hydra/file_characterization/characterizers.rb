module Hydra::FileCharacterization
  module Characterizers
  end

  module_function
  def characterizer(tool_name)
    characterizer_name = characterizer_name_from(tool_name)
    if Characterizers.const_defined?(characterizer_name)
      Characterizers.const_get(characterizer_name)
    else
      raise ToolNotFoundError.new(tool_name)
    end
  end

  def characterizer_name_from(tool_name)
    tool_name.to_s.gsub(/(?:^|_)([a-z])/) { $1.upcase }
  end
  
  def characterize_with(tool_name, file_path)
    tool_obj = characterizer(tool_name).new(file_path)
    tool_obj.call
  end

end

require 'hydra/file_characterization/characterizers/fits'
