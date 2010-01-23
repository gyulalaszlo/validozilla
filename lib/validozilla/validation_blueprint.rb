module Validozilla
  
  class ValidationBlueprint
    
    attr_accessor :klass_name
    attr_reader :attributes


    # a list of the validated fields (name only)
    attr_reader :field_names
    attr_reader :field_attributes
    
    def initialize
      @field_names = []
      @field_attributes = {}
    end
    
    def add_attribute field_name, *attrs
      @field_attributes[field_name] = [] unless @field_attributes[field_name]
      @field_attributes[field_name].push(*attrs)
    end
    
    
    def generate_with generator
      generator.entity_name = @klass_name
      
      generator.init!
      
      @field_names.each do |field_name|

        @field_attributes[field_name].each do |attrib|
          params = attrib.clone
          meth_name = params.shift
          generator.send meth_name, field_name, *params
        end
      end
      
      generator.save! ''
    end
    
    
  end
end