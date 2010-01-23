module Validozilla
  module Parsers
    
    class Required < Validozilla::Parser
      
      matches( /^required$/)
      exports :is_required
      
    end

    
    
  end
end