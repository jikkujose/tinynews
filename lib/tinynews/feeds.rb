require 'tinynews/feed'
require 'yaml'

module TinyNews

  class Feeds

    def initialize
      sources_file = File.open('sources.yml', 'r').read
      @sources = YAML::load( sources_file ) 
    end

    def generate source_symbol
      feeds = []
      case source_symbol
      when :all
        @sources.keys.each do |symbol|
          feeds << generate_feed_object_for( symbol )
        end
      else
        feeds << generate_feed_object_for( source_symbol )
      end
      feeds
    end

    private

    def generate_feed_object_for feed_symbol
      source = @sources[feed_symbol]
      source == nil ? nil : Feed.new( source[:title], source[:url] )
    end

  end 

end