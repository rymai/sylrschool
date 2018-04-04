# frozen_string_literal: true

module Classes
  module AppClasses
    # Build a Logger::Formatter subclass.
    class LogFormatter < Logger::Formatter
      # Provide a call() method that returns the formatted message.
      def initialize(*args)
        @NOLOGS = args[0]
        puts "LogFormatter: @NOLOGS=#{@NOLOGS}"
      end

      def call(severity, time, program_name, message)
        unless @NOLOGS.index { |x| !program_name.index(x).nil? }
          datetime = time.strftime('%Y-%m-%d %H:%M')
          # "ERROR"
          # print_message =[severity.ljust(5), datetime.to_s, program_name.to_s, message.to_s].join("|")
          print_message = [severity.ljust(5), program_name.to_s, message.to_s].join('|')
          #for log file
          ret = print_message + "\n"
          # for console
          puts print_message
        end
        ret
      end
    end
  end
end

# pour les fixtures
# module YAML
# def YAML.include file_name
# require 'erb'
# ERB.new(IO.read(file_name)).result
# end
# def YAML.load_erb file_name
# YAML::load(YAML::include(file_name))
# end
# end
