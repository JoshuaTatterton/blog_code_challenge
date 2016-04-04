feature "blogger" do
  
  context "on the home page" do
    scenario "there is a list of bloggers" do
      visit "/"

      expect(page)
    end
  end
  scenario "a bloggers url has their username in it" do
    Blogger.create(username: "My Username", email: "example@email.com", password: "randomletters")
    visit "/"

    click_link "My Username"

    expect(current_path).to eq "/bloggers/my-username/articles"
  end
  context "a prospective blogger" do
    scenario "can sign up", js: true do
      visit "/"

      expect(page).not_to have_css ".sign_up_form"

      sign_up

      expect(page).to have_content("You have signed up")
    end

    scenario "can't sign up without username", js: true do
      visit "/"

      expect(page).not_to have_css ".sign_up_form"

      sign_up(username: "")

      expect(page).to have_content("Sign up failed")
    end

    scenario "can't sign up with a already used username", js: true do
      Blogger.create(username: "MyUsername", email: "example@email.co.uk", password: "randomletters")
      visit "/"

      sign_up(email: "another@email.com")

      expect(page).to have_content("Sign up failed")
    end

    scenario "can't sign up without email address", js: true do
      visit "/"

      expect(page).not_to have_css ".sign_up_form"

      sign_up(email: "")

      expect(page).to have_content("Sign up failed")
    end

    scenario "can't sign up with a already used email address", js: true do
      Blogger.create(username: "Username", email: "example@email.co.uk", password: "randomletters")
      visit "/"

      sign_up(username: "another")

      expect(page).to have_content("Sign up failed")
    end

    scenario "can't sign up with different passwords", js: true do
      visit "/"

      expect(page).not_to have_css ".sign_up_form"

      sign_up(password_confirmation: "randomlett")

      expect(page).to have_content("Sign up failed")
    end

    scenario "can't sign up with password less than 8 characters", js: true do
      visit "/"

      expect(page).not_to have_css ".sign_up_form"

      sign_up(password: "random", password_confirmation: "random")

      expect(page).to have_content("Sign up failed")
    end
  end

  context "an existing blogger" do
    before(:each) do
      visit "/"

      sign_up
    end

    scenario "who's signed in can sign out", js: true do
      expect(page).to have_link("Sign Out")

      click_link "Sign Out"

      expect(page).to have_content("You have signed out")
      expect(page).not_to have_link("Sign Out")
      expect(current_path).to eq "/"
    end

    scenario "can sign in", js: true do
      click_link "Sign Out"

      expect(page).to have_button("Sign In")
      expect(page).not_to have_css ".sign_in_form"

      click_button "Sign In"
      within(".sign_in_form") do
        fill_in "Email", with: "example@email.co.uk"
        fill_in "Password", with: "randomletters"
        click_button "Sign In"
      end

      expect(page).to have_content("You have signed in")
      expect(page).not_to have_button("Sign In")
      expect(page).to have_button("New Article")
    end

    scenario "can't sign in if details are incorrect", js: true do
      click_link "Sign Out"

      click_button "Sign In"
      within(".sign_in_form") do
        fill_in "Email", with: "example@email.co.uk"
        fill_in "Password", with: "lettersrandom"
        click_button "Sign In"
      end

      expect(page).to have_content("Sign in failed")
      expect(page).to have_button("Sign In")
      expect(page).not_to have_button("New Article")
    end    
  end

end