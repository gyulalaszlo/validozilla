require File.dirname(__FILE__) + '/test_helper.rb'

class TestValidozilla < Test::Unit::TestCase

  def setup
  end
  
  def test_simple_init
    vz = Validozilla::Vz.new( :text => "Validate TestObject\n" )
    assert_equal ['Validate TestObject'], vz.expression_stream.contents
  end
  
  
  def test_simple_parsing
    vz = Validozilla::Vz.new( :file => vz_path('test_simple_file') )
    assert_equal ["Validate User",
     ["username is",
      ["required", "a string", "alphanumeric", "between 3 and 15 characters"]]], vz.expression_stream.contents
  end
  

  
end
