feature "subscriber" do
  let!(:blogger) { Blogger.create(username: "MyUsername", email: "example@email.com", password: "randomletters") }

  before(:each) do
    visit "/bloggers/#{blogger.id}/articles"
  end

  scenario "people can subscribe", js: true do
    click_button "Subscribe"
    fill_in "subscriber_email", with: "example@email.co.uk"

    expect { click_button "Become a Subscriber" }.to change(Subscriber, :count).by(1)
  end

  context "after subscribing visiter returns to the" do
    scenario "main page if started there", js: true do
      visiter_subscribe

      expect(current_path).to eq "/bloggers/#{blogger.id}/articles"
    end

    scenario "article page if started there", js: true do
      blogger.articles.create(title: "Example Title", content: "Hello World!!")

      visit current_path

      click_link "Example Title"

      visiter_subscribe

      expect(current_path).to eq "/bloggers/#{blogger.slug}/articles/example-title"
    end
  end
  
  scenario "raises error when no email is entered", js: true do
    click_button "Subscribe"
    click_button "Become a Subscriber"
    
    expect(page).to have_content "Email can't be blank"
  end
end