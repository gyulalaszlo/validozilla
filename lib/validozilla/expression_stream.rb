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
      
        @buffer = []
      end
    end
    
    
    
    def << element
      if element.is_a? Array
        element.reject! { |e| e == ''  }
        @buffer.push( *(element.flatten))
      else
        @buffer.push element.to_s
      end

      @index = @buffer.size - 1 
    end
    
    
    
    
    
    def level_up
      @current_depth -= 1
      @buffer << :up unless @current_depth < 0
      
    end
    
    
    
    
    
    def level_down
      @current_depth += 1
      @buffer << :down
    end
    
    
    def close!
      @current_depth.times { level_up }

      o = [:down_placeholder]
      
      @buffer.each_index do |i|
        current_element = @buffer[i]
        next_element = i < @buffer.size - 1 ? @buffer[i+1] : nil
        if next_element == :down
          o << :down_placeholder
          o << current_element
          o << :down
        else
          if next_element == nil
            o << :up_placeholder
          else
            o << current_element 
          end
        end
      end
      @contents = eval(stream_to_sexp(o) )

    end
    
    
    
    
    
    
    def [] idx
      @contents[idx]
    end

    private
    
    def to_sexp(element)
      return ']]' if element == :up
      return ']' if element == :up_placeholder
      return '[' if element == :down_placeholder
      return '[' if element == :down
      element.inspect
    end
    
    def stream_to_sexp o
      o.collect{|el| to_sexp(el) }.join(',').gsub(',[,[,',',[').gsub('[,','[').gsub(',]',']')
    end
    
  end
  
end