feature "search" do
  
  before(:each) { visit "/" }
  scenario "there is a search bar" do
    fill_in "search", with: "search term"
    click_button "search_button"

    expect(current_path).to eq "/search"
  end

  scenario "user can perform a basic 'strict' search" do
    blogger = Blogger.create( username: "Joshy", 
                              email: "example@email.co.uk", 
                              password: "randomletters", 
                              password_confirmation: "randomletters")
    article = blogger.articles.create(title: "My Article", option: "markdown", content: "This is some content")

    fill_in "search", with: "content"
    click_button "search_button"

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

    fill_in "search", with: "article"
    click_button "search_button"

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

    fill_in "search", with: "this"
    click_button "search_button"

    expect(page).to have_content "Search Results For \"this\":"
    expect(page).to have_content blogger.username
    expect(page).to have_content article.title
    expect(page).to have_content "This is some content"
  end

  scenario "displays message if no search term entered" do
    click_button "search_button"

    expect(page).not_to have_content "Search Results For \"\":"
    expect(page).to have_content "Please enter word/phrase to search."
  end

  scenario "displays message if no results are found" do
    fill_in "search", with: "this"
    click_button "search_button"

    expect(page).not_to have_content "Search Results For \"this\":"
    expect(page).to have_content 'No results found for "this"'
  end

  scenario "it prefills the search bar with the search term" do
    fill_in "search", with: "article"
    click_button "search_button"

    expect(page).to have_selector("input[value='article']")
  end

end