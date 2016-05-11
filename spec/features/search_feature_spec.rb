feature "search" do
  
  before(:each) { visit "/" }
  scenario "there is a search bar" do
    within(".o-nav__search") do
      fill_in "search", with: "search term"
      find("input.c-search__image").click
    end

    expect(current_path).to eq "/search"
  end

  scenario "user can perform a basic 'strict' search" do
    blogger = Blogger.create( username: "Joshy", 
                              email: "example@email.co.uk", 
                              password: "randomletters", 
                              password_confirmation: "randomletters")
    article = blogger.articles.create(title: "My Article", option: "markdown", content: "This is some content")

    within(".o-nav__search") do
      fill_in "search", with: "content"
      find("input.c-search__image").click
    end

    expect(page).to have_content "Search Results For \"content\":"
    expect(page).to have_content blogger.username
    expect(page).to have_content article.title
    expect(page).to have_content article.content
  end

  scenario "searches are not case sensitive" do
    blogger = Blogger.create( username: "Joshy", 
                              email: "example@email.co.uk", 
                              password: "randomletters", 
                              password_confirmation: "randomletters")
    article = blogger.articles.create(title: "My Article", option: "markdown", content: "This is some content")

    within(".o-nav__search") do
      fill_in "search", with: "article"
      find("input.c-search__image").click
    end

    expect(page).to have_content "Search Results For \"article\":"
    expect(page).to have_content blogger.username
    expect(page).to have_content article.title
    expect(page).to have_content article.content
  end

  scenario "searches work for wysiwyg articles" do
    blogger = Blogger.create( username: "Joshy", 
                              email: "example@email.co.uk", 
                              password: "randomletters", 
                              password_confirmation: "randomletters")
    article = blogger.articles.create(title: "My Article", option: "wysiwyg", wysiwyg_content: "<p>This is some content</p>")

    within(".o-nav__search") do
      fill_in "search", with: "this"
      find("input.c-search__image").click
    end
    expect(page).to have_content "Search Results For \"this\":"
    expect(page).to have_content blogger.username
    expect(page).to have_content article.title
    expect(page).to have_content "This is some content"
  end

  scenario "displays message if no search term entered" do
    within(".o-nav__search") do
      find("input.c-search__image").click
    end

    expect(page).not_to have_content "Search Results For \"\":"
    expect(page).to have_content "Please enter word/phrase to search."
  end

  scenario "displays message if no results are found" do
    within(".o-nav__search") do
      fill_in "search", with: "this"
      find("input.c-search__image").click
    end

    expect(page).not_to have_content "Search Results For \"this\":"
    expect(page).to have_content 'No results found for "this"'
  end

  scenario "it prefills the search bar with the search term" do
    within(".o-nav__search") do
      fill_in "search", with: "article"
      find("input.c-search__image").click
    end

    expect(page).to have_selector("input[value='article']")
  end
  context "Advanced Search" do
    scenario "there are advanced search options", js: true do
      within(".o-main__search") do
        find("input.c-main__search_image").click
      end

      expect(page).to have_css "label.c-search__option_btn"
      expect(page).not_to have_css ".o-search__options"

      find("label.c-search__option_btn").click

      expect(page).to have_css ".o-search__options"
    end

    scenario "can perform a non strict 'slack' search" do
      blogger = Blogger.create( username: "Joshy", 
                              email: "example@email.co.uk", 
                              password: "randomletters", 
                              password_confirmation: "randomletters")
      article = blogger.articles.create(title: "My Article", option: "markdown", content: "This is some content")

      within(".o-main__search") do
        find("input.c-main__search_image").click
      end
      find("label.c-search__option_btn").click

      within(".o-search__main") do
        fill_in "search", with: "Content here"
      end
        
      within (".o-search__options") do
        uncheck("strict_option")

        find("input.c-search__btn").click
      end

      expect(page).to have_content "Search Results For \"Content here\":"
      expect(page).to have_content blogger.username
      expect(page).to have_content article.title
      expect(page).to have_content article.content
    end

    scenario "is strict search by default" do
      blogger = Blogger.create( username: "Joshy", 
                              email: "example@email.co.uk", 
                              password: "randomletters", 
                              password_confirmation: "randomletters")
      article = blogger.articles.create(title: "My Article", option: "markdown", content: "This is some content")

      within(".o-main__search") do
        find("input.c-main__search_image").click
      end
      find("label.c-search__option_btn").click

      within(".o-search__main") do
        fill_in "search", with: "Content here"
      end
        
      within (".o-search__options") do
        find("input.c-search__btn").click
      end

      expect(page).not_to have_content "Search Results For \"Content here\":"
      expect(page).not_to have_content blogger.username
      expect(page).not_to have_content article.title
      expect(page).not_to have_content article.content

      expect(page).to have_content 'No results found for "Content here"'
    end

    scenario "can search for articles by a single blogger" do
      blogger = Blogger.create( username: "Joshy", 
                              email: "example@email.co.uk", 
                              password: "randomletters", 
                              password_confirmation: "randomletters")
      article = blogger.articles.create(title: "My Article", option: "markdown", content: "This is some content")

      blogger2 = Blogger.create( username: "NotJosh", 
                              email: "example@email.com", 
                              password: "randomletters", 
                              password_confirmation: "randomletters")
      article2 = blogger2.articles.create(title: "AnotherArticle", option: "markdown", content: "This is some more content")

      within(".o-main__search") do
        find("input.c-main__search_image").click
      end
      find("label.c-search__option_btn").click

      within(".o-search__main") do
        fill_in "search", with: "content"
      end
        
      within (".o-search__options") do
        fill_in "blogger", with: "joshy"
        find("input.c-search__btn").click
      end

      expect(page).to have_content "Search Results For \"content\" By \"joshy\":"
      
      expect(page).to have_content blogger.username
      expect(page).to have_content article.title
      expect(page).to have_content article.content

      expect(page).not_to have_content blogger2.username
      expect(page).not_to have_content article2.title
      expect(page).not_to have_content article2.content
    end

    scenario "displays message if blogger searched for doesn't exist" do

      within(".o-main__search") do
        find("input.c-main__search_image").click
      end
      find("label.c-search__option_btn").click

      within(".o-search__main") do
        fill_in "search", with: "content"
      end
        
      within (".o-search__options") do
        fill_in "blogger", with: "joshy"
        find("input.c-search__btn").click
      end

      expect(page).to have_content "Cannot find a blogger with username \"joshy\""
    end

    scenario "defaults to searching a bloggers articles when on their page" do
      blogger = Blogger.create( username: "Joshy", 
                              email: "example@email.co.uk", 
                              password: "randomletters", 
                              password_confirmation: "randomletters")
      article = blogger.articles.create(title: "My Article", option: "markdown", content: "This is some content")

      blogger2 = Blogger.create( username: "NotJosh", 
                              email: "example@email.com", 
                              password: "randomletters", 
                              password_confirmation: "randomletters")
      article2 = blogger2.articles.create(title: "AnotherArticle", option: "markdown", content: "This is some more content")

      visit "/bloggers/#{blogger.slug}/articles"

      
      within(".o-main__search") do
        fill_in "search", with: "content"
        find("input.c-main__search_image").click
      end

      expect(page).to have_content "Search Results For \"content\" By \"Joshy\":"
      
      expect(page).to have_content blogger.username
      expect(page).to have_content article.title
      expect(page).to have_content article.content

      expect(page).not_to have_content blogger2.username
      expect(page).not_to have_content article2.title
      expect(page).not_to have_content article2.content
    end
  end

end