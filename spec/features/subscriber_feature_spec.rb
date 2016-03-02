require "rails_helper"

feature "subscriber" do
  scenario "people can subscribe", js: true do
    visit "/"
    click_button "Subscribe"
    fill_in "subscriber_email", with: "example@email.co.uk"
    expect { click_button "Become a Subscriber" }.to change(Subscriber, :count).by(1)
  end
end