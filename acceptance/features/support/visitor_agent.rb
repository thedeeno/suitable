module Suitor
module Acceptance
  class VisitorAgent
    include RSpec::Matchers

    def initialize(name)
      @name = name
    end

    def session
      @session ||= Capybara::Session.new(:selenium)
    end

    def visit(url)
      session.visit(url)
    end

    def enter(field, value)
      session.fill_in field, with: value
    end

    def click(text)
      session.click_button(text)
    end

    # asserts the text or selector is on the page
    def see!(options)
      key,value = options.first
      case key
      when :text
        expect(session).to have_text(value)
      when :css
        expect(session).to have_css(value)
      else
        raise "Visitor doesn't know how to see #{key}"
      end

    end

  end
end
end
