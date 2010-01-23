module Validozilla
  module Generators
    
    class RubyPlain < Validozilla::AbstractGenerator
      
      def init!
        @output = IndentedBuffer.new
        
        @output << "class #{entity_name}Validator"
        @output.indent
        @output.include_file( File.dirname(__FILE__) + '/validation_header.tpl.rb')
        @output << "def validate! obj"
        @output.indent
        @output << "validation_errors.clear"
      end
      
      def save! path
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
      
      def is_string_length field, len
        @output << "is_valid( '#{field}', obj.#{field}.size == #{len}, [:is_string_length, #{len}] )"
      end
      
      
    end
    
  end
end