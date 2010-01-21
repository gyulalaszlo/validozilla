require 'stringio'
require 'test/unit'
require File.dirname(__FILE__) + '/../lib/validozilla'

def vz_path(filename)
  File.dirname(__FILE__) + '/validations/' + filename + '.vz'
end