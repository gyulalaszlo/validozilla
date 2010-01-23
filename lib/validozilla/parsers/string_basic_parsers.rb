p Validozilla::Parser

Validozilla::Parser.match do |p|
  p.map 'String', /^a string$/ => :is_string
  p.map 'Whitespace related', [ 'contains no spaces', 'one word' ] => :has_no_spaces
  
  p.map 'Alphanumeric string', 
    [
      /^alphanumeric$/,
      /^an alphanumeric string$/
    ] => :is_alphanumeric_string

  p.map 'Format checks', 
    [
      /^matches (.*?)$/,
      /^is in format (.*?)$/,
      /^has format (.*?)$/,
      /^has format of (.*?)$/,
    ] => [:has_format, '$1']
  
  p.map 'String lengths',
    [ 
      /^([0-9]+) characters$/, 
      /^([0-9]+) chars$/, 
      /^([0-9]+) long$/ 
    ] => [:is_string_length, '$1'],
      
    [
      /^at least ([0-9]+) characters$/, 
      /^at least ([0-9]+) chars$/, 
      /^min ([0-9]+) long$/, 
      /^min ([0-9]+) chars$/,
      /^min ([0-9]+) characters$/,
    ] => [:is_string_min_length, '$1'],
    
    [
      /^at most ([0-9]+) characters$/, 
      /^at most ([0-9]+) chars$/, 
      /^max ([0-9]+) long$/, 
      /^max ([0-9]+) chars$/,
      /^max ([0-9]+) characters$/,
    ] => [:is_string_max_length, '$1'],
    
    [
      /^between ([0-9]+) and ([0-9]+) characters$/, 
      /^between ([0-9]+) and ([0-9]+) chars$/
    ] => [:is_string_min_and_max_length, '$1', '$2']
  
  
end
