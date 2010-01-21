require File.dirname(__FILE__) + '/test_helper.rb'

class TestValidozilla < Test::Unit::TestCase

  def setup
  end
  
  def test_simple_init
    vz = Validozilla::Vz.new( :text => 'Validate TestObject' )
    assert_equal ['Validate TestObject'], vz.expression_stream
  end
  
  def test_simple_file_load
    vz = Validozilla::Vz.new( :file => vz_path('test_simple_file') )
    assert_equal ["Validate User",
     :level_down,
     "username is",
     "required",
     :level_down,
     "a string",
     "alphanumeric",
     "between 3 and 15 characters"], vz.expression_stream
  end
  
end
