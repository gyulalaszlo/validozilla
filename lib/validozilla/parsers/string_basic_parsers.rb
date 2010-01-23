module Validozilla
  module Parsers
    
    class AStringParser < Validozilla::Parser
      
      matches( /^a string$/)
      exports :is_string
      
    end
    
    
    class StringFixedLengthParser < Validozilla::Parser
      
      requires :is_string
      
      matches( /^([0-9]+) characters$/, 
              /^([0-9]+) chars$/,
              /^([0-9]+) long$/)
              
      exports :is_string_length, '$1'
    end
    
    
    class StringMinimumLengthParser < Validozilla::Parser
      requires :is_string
      
      matches( /^at least ([0-9]+) characters$/, 
              /^at least ([0-9]+) chars$/,
              /^min ([0-9]+) long$/)
              
      exports :is_string_min_length, '$1'  
    end
    
    
    class StringMaxmimumLengthParser < Validozilla::Parser
      requires :is_string
      
      matches( /^at most ([0-9]+) characters$/, 
              /^at most ([0-9]+) chars$/,
              /^max ([0-9]+) long$/)
              
      exports :is_string_max_length, '$1'  
    end
    
    
  end
end