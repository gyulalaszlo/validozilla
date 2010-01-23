require File.dirname(__FILE__) + '/test_helper'

class TestExpressionStreamParser < Test::Unit::TestCase
  def setup
  end
  
  def teardown
  end
  

  def test_klass_name_parsing
    vz = Validozilla::Vz.new( :text => "Validate TestObject" )
    stream = vz.expression_stream
    
    parser = Validozilla::ExpressionStreamParser.new
    parser.stream = stream
    parser.parse!
    output = parser.blueprint
    
    assert_equal( 'TestObject', output.klass_name )
  end
  

  def test_klass_fields
    stream = Validozilla::ExpressionStream.new [["Validate User", [['username is'], ['password is'], ['open_id is']]]]

    
    parser = Validozilla::ExpressionStreamParser.new
    parser.stream = stream
    parser.parse!
    output = parser.blueprint
    
    assert_equal( ['username', 'password', 'open_id'], output.field_names )
  end
  
  
  def test_klass_field_properties
    stream = Validozilla::ExpressionStream.new [["Validate User", [['username is', ['a string', 'at least 15 characters']]]]]

    
    parser = Validozilla::ExpressionStreamParser.new
    parser.stream = stream
    parser.parse!
    output = parser.blueprint
    
    assert_equal( ['username'], output.field_names )
    assert_equal( {'username' => [[:is_string], [:is_string_min_length, "15"]]}, output.field_attributes )
  end
  
  
  
  def test_klass_fields_from_file
    vz = Validozilla::Vz.new( :file => vz_path('test_parsers') )
    stream = vz.expression_stream
    parser = Validozilla::ExpressionStreamParser.new
    parser.stream = stream
    parser.parse!
    output = parser.blueprint

    assert_equal( ["username", "password", "calendar_address",  "calendar_username", "calendar_password"], output.field_names )
    assert_equal( {'username' => [[:is_string], [:is_string_min_length, "15"]]}, output.field_attributes )
    
  end
  
  
end
