require "rails_helper"

feature "blog" do
  scenario "message is displayed when there are no blog posts" do
    visit "/"
    expect(page).to have_content "No blog posts have been made"
  end
end