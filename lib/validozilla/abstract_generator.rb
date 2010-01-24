module Validozilla
  
  module AbstractGeneratorClassMethods
    module ClassMethods
      
      # define a method that outputs a given string
      
      def meth symbol, params , output
        module_eval( "def #{symbol.to_s}(field, #{params.collect{|p| p.to_s}.join(',')})  @output << \"#{output.gsub(/"/, '\"')}\" end")
      end
      
    end
    
    module InstanceMethods
      
    end
    
    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
  
  
  class AbstractGenerator

    attr_accessor :entity_name
    include AbstractGeneratorClassMethods
    
    def initialize

    end
    
    
    def start!
      @output = IndentedBuffer.new
      open!
    end
    
    def stop! path
      close! path
      @output.to_s
    end
    
  end
  
  
  class IndentedBuffer
    
    def initialize( spaces_per_indent = 2)
      @buf = []
      @indent = 0
      @spaces_per_indent = spaces_per_indent
    end
    
    def << ln
      @buf << "#{" " * (@indent * @spaces_per_indent)}#{ln}"
    end
    
    def indent
      @indent += 1
    end
    
    def outdent
      @indent -= 1 if @indent > 0
    end
    
    
    def include_file(path)
      IO.readlines(path).each {|ln| self << ln.rstrip }
    end
    
    
    
    
    def to_s
      @buf.join("\n")
    end
  end
  
  
  
end