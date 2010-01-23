module Validozilla
  class NoTextError < RuntimeError    
    attr_reader :file_name
    
    def initialize(file_name=nil)
      @file_name = file_name
    end
  end  


  class TabsUsedError < RuntimeError    
  end  
  
  
  class VzSyntaxError < RuntimeError
    
    attr_reader :message
    attr_reader :code
    attr_reader :hint
    
    def initialize(message, code, hint='')
      @message = message
      @code = code
      
      @hint = hint
    end
  end
  
  
  class NoExpressionMatchError < RuntimeError
    
    attr_reader :expression
    
    def initialize(expression)
      @expression = expression
    end
    
  end
end

