feature "comment" do

  before(:each) do
    visit "/"

    sign_up

    @blogger = Blogger.last
    @article = @blogger.articles.create(title: "Example Title", content: "Hello World!!")
  end
  
  scenario "is displayed" do
    @article.comments.create(name: "MyName", content: "I like this")
    
    visit "/bloggers/#{@blogger.slug}/articles/example-title"

    expect(page).to have_content "MyName:"
    expect(page).to have_content "I like this"
  end

  context "can be written" do
    scenario "from the individual article page", js: true do
      visit "/bloggers/#{@blogger.slug}/articles/example-title"

      click_button "Comment"
      fill_in "comment_name", with: "MyName"
      fill_in "comment_content", with: "I like this"
      click_button "Post Comment"

      expect(page).to have_content "MyName:"
      expect(page).to have_content "I like this"
    end

    scenario "signed in blogger can delete comments" do
      @article.comments.create(name: "MyName", content: "I like this")

      visit "/bloggers/#{@blogger.slug}/articles/example-title"

      click_link "Delete"

      expect(page).not_to have_content "MyName:"
      expect(page).not_to have_content "I like this"
    end

    scenario "not signed in blogger can't delete comments" do
      @article.comments.create(name: "MyName", content: "I like this")

      click_link "Sign out"

      visit "/bloggers/#{@blogger.slug}/articles/example-title"
      within(".comments") do
        expect(page).not_to have_link "Delete"
      end
    end
  end
  
  context "will show error" do
    scenario "without a name", js: true do
      visit "/bloggers/#{@blogger.slug}/articles/example-title"

      click_button "Comment"
      fill_in "comment_name", with: ""
      fill_in "comment_content", with: "I like this"
      click_button "Post Comment"

      expect(page).to have_content "Name can't be blank"
    end

    scenario "without content", js: true do
      visit "/bloggers/#{@blogger.slug}/articles/example-title"

      click_button "Comment"
      fill_in "comment_name", with: "MyName"
      fill_in "comment_content", with: ""
      click_button "Post Comment"

      expect(page).to have_content "Content can't be blank"
    end
  end
end