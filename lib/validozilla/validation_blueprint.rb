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
    
    
  end
end