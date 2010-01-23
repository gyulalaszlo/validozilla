require 'singleton'
require 'logger'

module Validozilla

  module ParserSetupMethods
    module ClassMethods

      attr_reader :regexp
      attr_reader :requirements
      attr_reader :exported_list
      
      # This parser matches the given regex
      def matches *regx
        @regexp = regx
      end
      
      def requires *req_symbols
        @requirements = req_symbols
      end
      
      def exports *exp_list
        @exported_list = *exp_list
      end
      
    end
    
    def self.included(receiver)
      receiver.extend         ClassMethods
    end
  end


  class Parser
    include ParserSetupMethods
    
    def self.inherited(subclass)
      ParserStore.instance.add subclass
    end
  end
  

  
  class ParserStore
    include Singleton
    
    attr_reader :parsers
    attr_accessor :validozilla_log
    
    def initialize
      @parsers = []
    end
    
    def add parser_klass
      @parsers << parser_klass
    end
    
    
    def match_parsers expr
      @parsers.each do |parser|
        parser.regexp.each do |rx|
          mtch = expr.match rx
          if mtch
            o = []
            # if the export is a symbol, return it in an array
            return [parser.exported_list] unless parser.exported_list.is_a? Array
            # if an array, return the array, but replace '$<int>' with the match data
            return parser.exported_list.collect { |o| o.is_a?(String) ?  o.gsub(/\$([0-9]+)/) { mtch[$1.to_i] } : o}
          end
        end
      end
      raise NoExpressionMatchError.new(expr)
      # puts("Can't match expression \"#{expr}\"")
      # no match
      # return nil
    end
    
  end
  
end