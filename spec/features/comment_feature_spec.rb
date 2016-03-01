require "rails_helper"

feature "comment" do
  scenario "is displayed" do
    @article = Article.create(title: "Example Title", content: "Hello World!!")
    @comment = Comment.create(name: "MyName", content: "I like this", article: @article)
    visit "/articles/example-title"
    expect(page).to have_content "MyName:"
    expect(page).to have_content "I like this"
  end
  context "can be written" do
    before(:each) do
      @article = Article.create(title: "Example Title", content: "Hello World!!")
    end
    scenario "from the individual article page", js: true do
      visit "/articles/example-title"
      click_button "Comment"
      fill_in "comment_name", with: "MyName"
      fill_in "comment_content", with: "I like this"
      click_button "Post Comment"
      expect(page).to have_content "MyName:"
      expect(page).to have_content "I like this"
    end
  end
end