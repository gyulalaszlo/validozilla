require File.dirname(__FILE__) + '/test_helper'
require 'ostruct'


class TestTestRubyGenerator < Test::Unit::TestCase
  def setup
  end
  
  def teardown
  end
  
  # Replace this with your real tests.
  def test_klass_name_generation
    blueprint = Validozilla::ValidationBlueprint.new
    blueprint.klass_name = 'TestKlassNameTestObject'
    
    generator = Validozilla::Generators::RubyPlain.new
    result = blueprint.generate_with( generator)
    
    eval(result)
    validator = TestKlassNameTestObjectValidator.new
    
    user =  OpenStruct.new('username' => 'gyula.laszlo', 'password' => 'secret')
    assert_equal(  {}, validator.validate!( user ) )
  end
  
  
  
  def test_simple_properties_generation
    blueprint = Validozilla::ValidationBlueprint.new
    blueprint.klass_name = 'SimplePropertiesTestObject'
    blueprint.field_names << 'username'
    blueprint.field_names << 'password'
    
    blueprint.add_attribute 'username', [:is_string]
    blueprint.add_attribute 'password', [:is_string]
    
    generator = Validozilla::Generators::RubyPlain.new
    result = blueprint.generate_with( generator)

    eval(result)
    validator = SimplePropertiesTestObjectValidator.new
    
    user =  OpenStruct.new('username' => 'gyula.laszlo', 'password' => 'secret')
    assert_equal(  {}, validator.validate!( user ) )
    
    user.password = nil
    assert_equal( { 'password' => [[:is_string]]}, validator.validate!(user))
    
    user.username = nil
    user.password = 'secret'
    assert_equal( { 'username' => [[:is_string]]}, validator.validate!(user))
  end
  
  
  
  
  def test_fixed_length_generator
    blueprint = Validozilla::ValidationBlueprint.new
    blueprint.klass_name = 'StringFixedLengthTestObject'
    blueprint.field_names << 'username'
    
    blueprint.add_attribute 'username', [:is_string], [:is_string_length, '8']
    
    generator = Validozilla::Generators::RubyPlain.new
    result = blueprint.generate_with( generator)

    eval(result)
    validator = StringFixedLengthTestObjectValidator.new
    
    user =  OpenStruct.new('username' => 'gyulalas')
    assert_equal(  {}, validator.validate!( user ) )
    
    user.username = ''
    assert_equal( { 'username' => [[:is_string_length, 8]]}, validator.validate!(user))
                                                        
    user.username = 'gyula.laszlo'                      
    assert_equal( { 'username' => [[:is_string_length, 8]]}, validator.validate!(user))

  end
  
  
  def test_min_length_generator
    blueprint = Validozilla::ValidationBlueprint.new
    blueprint.klass_name = 'StringMinLengthTestObject'
    blueprint.field_names << 'username'
    
    blueprint.add_attribute 'username', [:is_string], [:is_string_min_length, '8']
    
    generator = Validozilla::Generators::RubyPlain.new
    result = blueprint.generate_with( generator)

    eval(result)
    validator = StringMinLengthTestObjectValidator.new
    
    user =  OpenStruct.new('username' => 'gyulalas')
    assert_equal(  {}, validator.validate!( user ) )
    
    user.username = ''
    assert_equal( { 'username' => [[:is_string_min_length, 8]]}, validator.validate!(user))
                                                        
    user.username = 'gyula.laszlo'                      
    assert_equal( {}, validator.validate!(user))

  end
  
  def test_max_length_generator
    blueprint = Validozilla::ValidationBlueprint.new
    blueprint.klass_name = 'StringMaxLengthTestObject'
    blueprint.field_names << 'username'
    
    blueprint.add_attribute 'username', [:is_string], [:is_string_max_length, '8']
    
    generator = Validozilla::Generators::RubyPlain.new
    result = blueprint.generate_with( generator)

    eval(result)
    validator = StringMaxLengthTestObjectValidator.new
    
    user =  OpenStruct.new('username' => 'gyulalas')
    assert_equal(  {}, validator.validate!( user ) )
    
    user.username = ''
    assert_equal( {}, validator.validate!(user))
                                                        
    user.username = 'gyula.laszlo'                      
    assert_equal( { 'username' => [[:is_string_max_length, 8]]}, validator.validate!(user))

  end
end
