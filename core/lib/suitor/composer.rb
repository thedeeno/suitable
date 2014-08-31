module Suitor

  # Composes charms from reddit links.
  class Composer

    # Returns a string representation of given link
    def compose(link)
      "#{link.title} #{link.url}"
    end
  end

end
