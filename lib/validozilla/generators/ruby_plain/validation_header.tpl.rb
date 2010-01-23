attr_reader :validation_errors

def initialize
  @validation_errors = {}
end

def is_valid field, expr, exports
  unless expr
    validation_errors[field]  = [] unless validation_errors[field]
    validation_errors[field] << exports
  end
end