require "rails_helper"

feature "blogger" do
  scenario "the blogger can sign in" do
    visit "/"
    fill_in "email", with: "example@email.co.uk"
    fill_in "password", with: "randomletters"
    click_button "Sign in"
    expect(page).to have_content "Would you like to post a blog article?"
    expect(page).not_to have_button "Sign in"
  end
end