require 'capybara'

describe "sending a valid charm" do
  specify do
    session = Capybara::Session.new :selenium
    session.visit "localhost:9230"
    session.fill_in "phone_number", with: MAGIC_NUMBERS[:valid]
    session.fill_in "subreddit", with: "romance"
    session.click_button "Charm"
    expect(session).to have_text("Charm sent!")
  end
end
