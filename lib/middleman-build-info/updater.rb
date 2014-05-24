require 'middleman-build-info/monkey'
require 'json'

module Middleman
  module BuildInfo
    class Updater

      def initialize(app, options)
        @app            = app
        @options        = options
        @file           = File.join(@app.root_path, @options[:relative_path], @options[:filename])
        @file_relative  = File.join(@options[:relative_path], @options[:filename]).without_leading_slash
      end

      def update_build_info(builder)
        @builder  = builder
        @backup   = read_info_file
        new_info  = get_updated_info(@backup)
        write_info_file(new_info)
      end

      def validate_procedure
        write_info_file(@backup) if @builder.had_errors
      end

      private

      def write_info_file info
        json = "// Hands off!\n" + JSON.pretty_generate(info)
        File.open(@file, "w") { |f| f.write(json) }
      end

      def read_info_file
        JSON.parse(File.read(@file))
      rescue Errno::ENOENT, JSON::ParserError
        default_template
      end

      def get_updated_info info
        puts info
        info["number"] = info["number"].to_i + 1
        info["date"]   = Time.now.utc.to_s
        info
      end

      def default_template
        { number: 0, date: '' }
      end

    end
  end
end
