require 'middleman-build-info/monkey'
require 'json'

module Middleman
  module BuildInfo
    class Updater

      def initialize(app, options)
        @start_time     = Time.now
        @app            = app
        @options        = options
        @file           = File.join(@app.root_path, @options[:relative_path], @options[:filename])
        @file_relative  = File.join(@options[:relative_path], @options[:filename]).without_leading_slash

        @backup = read_info_file
        app.set :build_info, @backup
      end

      def update_build_info(builder)
        @builder  = builder
        @new_info  = get_updated_info(@backup)
        write_info_file(@new_info) do
          @builder.say_status('update', @file_relative, :yellow)
        end
      end

      def wrap_up
        return print_build_info(@new_info) unless @builder.had_errors
        write_info_file(@backup) do
          @builder.say_status('rollback', @file_relative, :yellow)
        end
      end

      private

      def write_info_file(info, &block)
        json = "// Hands off!\n" + JSON.pretty_generate(info)
        File.open(@file, "w") { |f| f.write(json) }
        yield block
      rescue
        @builder.say_status('failed', @file_relative, :red)
      end

      def read_info_file
        JSON.parse(File.read(@file)).symbolize_keys
      rescue Errno::ENOENT, JSON::ParserError
        default_template
      end

      def get_updated_info(info)
        info[:number] = info[:number].to_i + 1
        info[:date]   = Time.now.utc.to_s
        info
      end

      def default_template
        { number: 0, date: '' }
      end

      def elapsed_time
        diff = ((Time.now - @start_time) * 1000).ceil
        ss, ms = diff.divmod(1000)
        mm, ss = ss.divmod(60)
        time = []
        time << "minute".pluralized_count(mm) unless mm.zero?
        time << "second".pluralized_count(ss) unless ss.zero?
        time << "millisecond".pluralized_count(ms) if time.empty? or not ms.zero?
        time.join(', ')
      end

      def print_build_info(info)
        return unless @options[:display_info_after_build]
        @builder.say("\n   Build Info:")
        info.each_pair do |name, value|
          @builder.say_status(name.to_s, value, :green)
        end
        @builder.say("\n   Finished in #{elapsed_time}.")
      end

    end
  end
end
