require "rails_helper"

feature "comment" do
  before(:each) do
    @article = Article.create(title: "Example Title", content: "Hello World!!")
    @comment = Comment.create(name: "MyName", content: "I like this", article: @article)
  end
  scenario "the comment is displayed" do
    visit "/articles/example-title"
    expect(page).to have_content "MyName:"
    expect(page).to have_content "I like this"
  end
end