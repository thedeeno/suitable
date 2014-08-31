module Suitor

  # Composes charms from reddit links.
  class Composer
    def initialize(reddit)
      @reddit = reddit
    end

    def compose(sub)
      link = @reddit.top_link(sub)
      Message.new({
        url: link.url,
        title: link.title
      })
    end
  end

end
