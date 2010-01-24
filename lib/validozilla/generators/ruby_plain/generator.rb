module Validozilla
  module Generators
    
    class RubyPlain < Validozilla::AbstractGenerator
      
      def open!
       
        
        @output << "class #{entity_name}Validator"
        @output.indent
        @output.include_file( File.dirname(__FILE__) + '/validation_header.tpl.rb')
        @output << "def validate! obj"
        @output.indent
        @output << "validation_errors.clear"
      end
      
      def close! path
        @output << "return validation_errors"        
        @output.outdent        
        @output << "end"
        # @output << "module_function :validate!"
        @output.outdent     
        @output << "end"
        @output.to_s
      end
      
      
      
      def is_string field
        @output << "is_valid( '#{field}', obj.#{field}.is_a?(String), [:is_string] )"
      end
      
      # meth :is_string, 'is_valid( "#{field}", obj.#{field}.is_a?(String), [:is_string] )'
      
      meth :is_string_length, [:len], 
            'is_valid( "#{field}", obj.#{field}.size == #{len}, [:is_string_length, #{len}] )'
      
      meth :is_string_min_length, [:len], 
            'is_valid( "#{field}", obj.#{field}.size >= #{len}, [:is_string_min_length, #{len}] )'
      
      meth :is_string_max_length, [:len], 
            'is_valid( "#{field}", obj.#{field}.size <= #{len}, [:is_string_max_length, #{len}] )'
      

      
    end
    
  end
end