module Validozilla
  
  # Central class for validozilla
  class Vz
    
    attr_reader :text
    attr_reader :filename
    attr_reader :expression_stream
    


    # create a new validation generator
    # options:
    #  :file => <a file> loads a vz file
    #  :text => <some text> generates from the text
    def initialize(options={})
      options = {:file => nil, :text => nil}.merge options
      
      if options[:file]
        @filename = options[:file]
        @text = IO.readlines( @filename ).to_s
      end
      
      if options[:text]
        @text = options[:text]
        @filename = nil
      end
      
      raise( NoTextError, @filename ) if @text == nil
      

      
      split
      
    end
    
    
    private
    
    def split
      raise TabsUsedError if @text =~ /\t/  
      
      lines = filter_text @text

      last_line_indent, current_line_indent = 0, 0
      @expression_stream = ExpressionStream.new

      while l = lines.shift
        
        
        indent_str = l.match( /^( *)/)
        current_line_indent = indent_str.to_s.length
        
        if last_line_indent < current_line_indent
          @expression_stream.level_down
        end
        
        if last_line_indent > current_line_indent
          @expression_stream.level_up
        end
        
        @expression_stream << preprocess_line( l)  
        last_line_indent = current_line_indent
      end
      
      @expression_stream.close!
    end
    
    # Strip away empty lines and comments
    def filter_text txt
      txt.split("\n").reject { |l| l =~ /^[ ]*$/ or l =~ /^[ ]*#(.*?)$/ }
    end
    
  
    # Split up a line by ','
    def preprocess_line line
      line.split(/,/).collect { |l| l.strip }
    end
    
    
  end
end