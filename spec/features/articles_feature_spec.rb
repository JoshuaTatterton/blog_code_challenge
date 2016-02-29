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
  context "while signed in as a blogger" do
    before(:each) do
      visit "/"
      fill_in "email", with: "example@email.co.uk"
      fill_in "password", with: "randomletters"
      click_button "Sign in"
    end
    scenario "articles can be written", js: true do
      click_button "new_article"
      fill_in "article_content", with: "Hello World!!"
      click_button "Post Article"
      expect(page).to have_content "Hello World!!"
    end
    context "articles can be" do
      before(:each) do
        Article.create(content: "Hello World!!")
      end
      xscenario "articles can be edited" do
        click_button "Edit Article 1"
        fill_in "article_content"
        expect(page).to have_content "Hello New World!!"
      end
    end
  end
end