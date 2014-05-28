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
      @updater.wrap_up
    end

    helpers do
      def build_info(key=nil)
        return config[:build_info] if key.nil?
        config[:build_info][key.to_sym] || nil
      end
    end

  end
end