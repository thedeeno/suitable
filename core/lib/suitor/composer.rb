module Suitor

  # Composes charms from reddit links.
  class Composer
    # The url shortener to service to use when
    # generating message
    def shortener
      @shortener ||= Googl.new
    end

    # Returns a string representation of given link
    #
    # Shotens the url with current shortener
    def compose(link)
      s = shortener.shorten(link.url)
      "#{link.title}\n#{s.short_url}"
    end

  end

end
