feature "subscriber" do
  let!(:blogger) { Blogger.create(username: "MyUsername", email: "example@email.com", password: "randomletters") }

  before(:each) do
    visit "/bloggers/#{blogger.slug}/articles"
  end

  scenario "people can subscribe" do
    fill_in "subscriber_email", with: "example@email.co.uk"

    expect { click_button "Subscribe" }.to change(Subscriber, :count).by(1)
  end

  context "after subscribing visiter returns to the" do
    scenario "main page if started there" do
      visiter_subscribe

      expect(current_path).to eq "/bloggers/#{blogger.slug}/articles"
    end
  end
  
  scenario "raises error when no email is entered" do
    click_button "Subscribe"
    
    expect(page).to have_content "Email can't be blank"
  end
end