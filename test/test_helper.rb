require 'stringio'
require 'test/unit'
require File.dirname(__FILE__) + '/../lib/validozilla'

def vz_path(filename)
  File.dirname(__FILE__) + '/validations/' + filename + '.vz'
end

def gen_output(generator_name, file)
  IO.readlines( File.join( File.dirname(__FILE__), 'generator_tests', generator_name, file + '.out'  )).to_s
end