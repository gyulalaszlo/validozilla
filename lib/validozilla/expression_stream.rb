module Validozilla
  
  class ExpressionStream
    
    attr_reader :contents
    attr_reader :current_depth
    
    def initialize
      @contents = []
      @current_depth = 0
    end
    
    def << element
      if element.is_a? Array
        element.reject! { |e| e == ''  }
        @contents.push *(element.flatten)
      else
        @contents.push element.to_s
      end
    end
    
    def level_up
      @current_depth -= 1
      @contents << :up
    end
    
    def level_down
      @current_depth += 1
      @contents << :down
    end
    
    
    def close
      @current_depth.times { level_up }
    end
    
    
  end
  
end