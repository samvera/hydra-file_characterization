module Hydra::FileCharacterization

  class UnspecifiedToolPathError < RuntimeError
    def initialize(tool_class)
      super("Unspecified tool path for #{tool_class}")
    end
  end

  class FileNotFoundError < RuntimeError
  end

  class ToolNotFoundError < RuntimeError
    def initialize(tool_name)
      super("Unable to find Hydra::FileCharacterization tool with name :#{tool_name}")
    end
  end

end
