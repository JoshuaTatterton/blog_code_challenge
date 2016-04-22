feature "search" do
  
  scenario "there is a search bar" do
    visit "/"

    fill_in "search", with: "search term"
    click_button "search_button"

    expect(current_path).to eq "/search"
  end

end