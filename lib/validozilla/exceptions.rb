module Validozilla
  class NoTextError < RuntimeError    
    attr_reader :file_name
    
    def initialize(file_name=nil)
      @file_name = file_name
    end
  end  


  class TabsUsedError < RuntimeError    
  end  
end

