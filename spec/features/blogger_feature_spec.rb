require "rails_helper"

feature "blogger" do
  scenario "the blogger can sign in" do
    visit "/"
    fill_in "email", with: "example@email.co.uk"
    fill_in "password", with: "randomletters"
    click_button "Sign in"
    expect(page).to have_button "New Article"
    expect(page).not_to have_button "Sign in"
  end
  context "after signing in the blogger returns to the" do
    scenario "main page if started there", js: true do
      visit "/"
      sign_in
      expect(current_path).to eq "/"
    end
    scenario "article page if started there", js: true do
      Article.create(title: "Example Title", content: "Hello World!!")
      visit "/articles/example-title"
      sign_in
      expect(current_path).to eq "/articles/example-title"
    end
  end
  scenario "raises error if details are wrong" do
    visit "/"
    fill_in "email", with: "wrong.email@email.co.uk"
    fill_in "password", with: "wrong_password"
    click_button "Sign in"
    expect(page).to have_content "Wrong email or password, only try to sign in if your write the blog."
  end
end