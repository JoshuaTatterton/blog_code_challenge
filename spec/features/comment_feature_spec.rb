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
    scenario "signed in blogger can delete comments", js: true do
      visit "/articles/example-title"
      write_comment
      sign_in
      visit "/articles/example-title"
      click_link "Delete Comment"
      expect(page).not_to have_content "MyName:"
      expect(page).not_to have_content "I like this"
    end
  end
  context "will show error" do
    before(:each) do
      @article = Article.create(title: "Example Title", content: "Hello World!!")
    end
    scenario "without a name", js: true do
      visit "/articles/example-title"
      click_button "Comment"
      fill_in "comment_name", with: ""
      fill_in "comment_content", with: "I like this"
      click_button "Post Comment"
      expect(page).to have_content "Name can't be blank"
    end
    scenario "without content", js: true do
      visit "/articles/example-title"
      click_button "Comment"
      fill_in "comment_name", with: "MyName"
      fill_in "comment_content", with: ""
      click_button "Post Comment"
      expect(page).to have_content "Content can't be blank"
    end
  end
end