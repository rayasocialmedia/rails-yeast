module Rsm
  class SetupGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)
    argument :name, type: :string, require: true
    def setup
    end
  end
end
