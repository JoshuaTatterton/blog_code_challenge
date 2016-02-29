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
end