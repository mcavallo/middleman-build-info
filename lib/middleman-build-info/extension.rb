require 'middleman-build-info/updater'

module Middleman
  class BuildInfoExtension < Extension

    option :filename, 'build.json', 'Build filename.'
    option :relative_path, 'source', 'Relative path to build file from MM root.'
    option :debug, true, ''

    def initialize(app, options_hash={}, &block)
      super
    end

    def after_configuration
      @updater = BuildInfo::Updater.new(@app, options)
    end

    def before_build(builder)
      @updater.update_build_info(builder)      
    end

    def after_build
      @updater.validate_procedure
    end

  end
end