require 'singleton'
require 'logger'

module Validozilla
  
  
  module ParserDeclarations
    module ClassMethods
      
      
      attr_reader :matches
      
      # declare a match
      # 
      # examples:
      #
      #     p.map 'String', /^a string$/ => :is_string
      #     p.map 'Alphanumeric string', /^alphanumeric$/ => :is_alphanumeric_string
      #     
      #     p.map 'String lengths',
      #       [ 
      #         /^([0-9]+) characters$/, 
      #         /^([0-9]+) chars$/, 
      #         /^([0-9]+) long$/ 
      #       ] => [:is_string_length, '$1'],
      #     
      def map description, matchings={}
        @matches = {} unless @matches
        
        matchings.each_pair do |key, val|
          exports = (val.is_a? Array )? val : [val]
          
          if key.is_a? Array
            key.each do |k|
              @matches[k] = exports
            end
          else
            @matches[key] = exports
          end
          
        end
      end
      
      def match &block
        yield(self)
      end
      
      
    end
    
    module InstanceMethods
      
    end
    
    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
  

  class Parser
    
    include ParserDeclarations
    
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
      Parser.matches.each_pair do |rx, output|
          mtch = expr.match rx
          if mtch
            o = []
            # if an array, return the array, but replace '$<int>' with the match data
            return output.collect { |o| o.is_a?(String) ?  o.gsub(/\$([0-9]+)/) { mtch[$1.to_i] } : o}
          end
      end
      raise NoExpressionMatchError.new(expr)
      # puts("Can't match expression \"#{expr}\"")
      # no match
      # return nil
    end
    
  end
  
end