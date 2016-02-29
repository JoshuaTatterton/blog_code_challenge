require "rails_helper"

feature "blog" do
  scenario "message is displayed when there are no blog posts" do
    visit "/"
    expect(page).to have_content "No blog posts have been made."
  end
  context "when a blog post has been created" do
    before(:each) do
      Article.create(content: "Hello World!!")
    end
    scenario "the article is displayed" do
      visit "/"
      expect(page).to have_content "Hello World!!"
      expect(page).not_to have_content "No blog posts have been made."
    end
  end
  context "when signed in as a blogger" do
    before(:each) do
      Blogger.create(email: "example@email.co.uk", password: "randomletters")
      visit "/"
      fill_in "blogger_email", with: "example@email.co.uk"
      fill_in "blogger_password", with: "randomletters"
      click_button "Sign in"
    end
    scenario "articles can be written" do
      fill_in "article_content", with: "Hello World!!"
      click_button "Post Article"
      expect(page).to have_content "Hello World!!"
    end
  end
end