module Validozilla
  
  class ExpressionStreamParser
    
    attr_reader :stream
    attr_reader :blueprint
    


    def initialize
      @blueprint = ValidationBlueprint.new
      
      loader = Validozilla::ParserLoader.new
      loader.add_path File.join( File.dirname(__FILE__), 'parsers')
      loader.load!      
    end
    
    def stream= stream
      @stream = stream
    end
    
    
    
    def parse!
      
      get_validation_class_name
      
    end
    
    
    private
    
    def syntax_error message, code, hint
      raise VzSyntaxError.new(message, code, hint)
    end
    
    def match_with_syntax_error expr, regex, message, hint
      match_data = expr.match regex
      syntax_error message, expr, hint unless match_data
      match_data
    end
    
    
    KLASS_NAME_REGEX = /^Validate (.*?)$/
    FIELD_IS_REGEX = /^(.*?) is$/
    
    # Read the target entity's name
    def get_validation_class_name

      @stream.contents.each do |exprs|
        if exprs.is_a? Array
          first_expr = exprs[0]

          klass_match = first_expr.match KLASS_NAME_REGEX
          syntax_error 'Validation target class name required', first_expr, "The first expression in the vz file should be\n\rValidate <target_entity_name>" unless klass_match
          @blueprint.klass_name = klass_match[1]
          get_fields exprs[1]
        else
          klass_match = exprs.match KLASS_NAME_REGEX
          syntax_error 'Validation target class name required', first_expr, "The first expression in the vz file should be\n\rValidate <target_entity_name>" unless klass_match
          @blueprint.klass_name = klass_match[1]
        end
      end
    end
    
    
    
    # Read the target_entity's fields
    def get_fields elements
      elements.each do |expr|
        if expr.is_a? Array
          field_match = match_with_syntax_error expr[0], FIELD_IS_REGEX, 'A field name must be given', 'Add a vaidated field with "<field_name> is"'
          field_name = field_match[1]
          @blueprint.field_names << field_name
          field_properties = get_field_properties( expr, field_name)
          @blueprint.add_attribute( field_name, *field_properties)
          
          # puts "added field #{field_name} with value #{field_properties.inspect}"
        end
      end
    end
    
    
    
    def get_field_properties input_expr, field_name
      o = []
      # p input_expr
      # one level deeper
      return nil unless input_expr[1].is_a? Array
      input_expr[1].each do |expr|
        begin
          o << ParserStore.instance.match_parsers( expr )
        rescue NoExpressionMatchError => e
          puts "Can't match expression: \"#{e.expression}\" in field #{field_name}"
        end
      end  
      return nil if o.size == 0
      o
    end
    
    
  end
end