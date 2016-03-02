require "rails_helper"

feature "subscriber" do
  scenario "people can subscribe", js: true do
    visit "/"
    click_button "Subscribe"
    fill_in "subscriber_email", with: "example@email.co.uk"
    expect { click_button "Become a Subscriber" }.to change(Subscriber, :count).by(1)
  end
  context "after subscribing visiter returns to the" do
    scenario "main page if started there", js: true do
      visit "/"
      visiter_subscribe
      expect(current_path).to eq "/"
    end
    scenario "article page if started there", js: true do
      Article.create(title: "Example Title", content: "Hello World!!")
      visit "/articles/example-title"
      visiter_subscribe
      expect(current_path).to eq "/articles/example-title"
    end
  end
end