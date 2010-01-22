$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))


%w(
  vz 
  exceptions 
  expression_stream 
  expression_stream_parser 
  validation_blueprint

  parser
  parser_loader
).each { |f| require "validozilla/#{f}"}



module Validozilla
  VERSION = '0.0.1'
end

validozilla_log = Logger.new(STDOUT)
validozilla_log.level = Logger::WARN

