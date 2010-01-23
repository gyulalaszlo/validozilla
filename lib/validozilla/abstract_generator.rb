module Validozilla
  
  class AbstractGenerator

    attr_accessor :entity_name
    
    
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