module Suitor

  class Message
    attr_accessor :title
    attr_accessor :url

    def initialize(options)
      @title = options[:title]
      @url = options[:url]
    end

    def to_s
      "#{title} #{url}"
    end

    # messages are equivalent when both title and url are eq
    def ==(other)
      title == other.title and url == other.url
    end
  end

end
