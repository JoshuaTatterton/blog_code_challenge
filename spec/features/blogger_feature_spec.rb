require "rails_helper"

feature "blogger" do
  before :each do
    Blogger.create(email: "example@email.co.uk", password: "randomletters")
  end
  scenario "the blogger can sign in" do
    visit "/"
    fill_in "blogger_email", with: "example@email.co.uk"
    fill_in "blogger_password", with: "randomletters"
    click_button "Sign in"
    expect(page).to have_content "Would you like to post a blog article?"
  end
end