module Validozilla
  
  class ExpressionStream
    
    attr_reader :contents
    attr_reader :current_depth
    
    attr_reader :index
    
    def initialize an_array=nil
      if an_array
        @contents = an_array
        @current_depth = 0
      else
        @contents = []
        @current_depth = 1
        @index = 0
      
        @current = []
        @nesting = [@current]
      end
    end
    
    
    
    def << element
      if element.is_a? Array
        element.reject! { |e| e == ''  }
        @current.push( *(element.flatten))
      else
        @current.push element.to_s
      end

      @index = @contents.size - 1 
    end
    
    
    
    
    
    def level_up
      @current_depth -= 1

      @current = @nesting.pop
      @contents = @current if @current_depth == 0
    end
    
    
    
    
    
    def level_down
      @current_depth += 1
      new_level = []
      @current << new_level
      
      @nesting.push @current
      @current = new_level
    end
    
    
    def close!
      @current_depth.times { level_up }
    end
    
    
    def [] idx
      @contents[idx]
    end

    
    
    
  end
  
end