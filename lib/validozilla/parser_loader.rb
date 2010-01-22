module Validozilla
  
  class ParserLoader
    
    attr_reader :paths
    
    def initialize
      @paths = []
    end
    
    def add_path path
      @paths << path unless @paths.include? path
    end
    
    def load!
      @paths.each do |path|
        parser_glob = File.join(path, '**', '*.rb' )
        Dir.glob(parser_glob).each do |f|
          require f
        end
      end
    end
    
    
  end
end