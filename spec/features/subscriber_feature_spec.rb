require "rails_helper"

feature "subscriber" do
  before(:each) { visit "/" }

  scenario "people can subscribe", js: true do
    click_button "Subscribe"
    fill_in "subscriber_email", with: "example@email.co.uk"

    expect { click_button "Become a Subscriber" }.to change(Subscriber, :count).by(1)
  end

  context "after subscribing visiter returns to the" do
    scenario "main page if started there", js: true do
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
  
  scenario "raises error when no email is entered", js: true do
    click_button "Subscribe"
    click_button "Become a Subscriber"
    
    expect(page).to have_content "Email can't be blank"
  end
end