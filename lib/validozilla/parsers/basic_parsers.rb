Validozilla::Parser.match do |p|
  p.map 'Required', /^required$/ => :is_required
end
