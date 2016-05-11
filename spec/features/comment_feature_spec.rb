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
    scenario "from the individual article page" do
      visit "/bloggers/#{@blogger.slug}/articles/example-title"

      find("label", text: "Comment").click
      fill_in "comment_name", with: "MyName"
      fill_in "comment_content", with: "I like this"
      click_button "Comment"

      expect(page).to have_content "MyName:"
      expect(page).to have_content "I like this"
    end

    scenario "signed in blogger can delete comments" do
      @article.comments.create(name: "MyName", content: "I like this")

      visit "/bloggers/#{@blogger.slug}/articles/example-title"

      within(".o-comments") do
        click_link "Delete"
      end
      
      expect(page).not_to have_content "MyName:"
      expect(page).not_to have_content "I like this"
    end

    scenario "not signed in blogger can't delete comments" do
      @article.comments.create(name: "MyName", content: "I like this")

      click_link "Sign out"

      visit "/bloggers/#{@blogger.slug}/articles/example-title"
      within(".o-comments") do
        expect(page).not_to have_link "Delete"
      end
    end
  end
  
  context "will show error" do
    scenario "without a name" do
      visit "/bloggers/#{@blogger.slug}/articles/example-title"

      find("label", text: "Comment").click

      fill_in "comment_name", with: ""
      fill_in "comment_content", with: "I like this"
      click_button "Comment"

      expect(page).to have_content "Name can't be blank"
    end

    scenario "without content" do
      visit "/bloggers/#{@blogger.slug}/articles/example-title"

      find("label", text: "Comment").click
      fill_in "comment_name", with: "MyName"
      fill_in "comment_content", with: ""
      click_button "Comment"

      expect(page).to have_content "Content can't be blank"
    end
  end
end