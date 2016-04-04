require "rails_helper"

feature "blogger" do
  
  context "a prospective blogger" do
    scenario "can sign up", js: true do
      visit "/"

      expect(page).not_to have_css ".sign_up_form"

      click_button "sign_up"
      within(".sign_up_form") do
        fill_in "Email", with: "example@email.co.uk"
        fill_in "Password", with: "randomletters"
        fill_in "Password confirmation", with: "randomletters"
        click_button "Sign Up"
      end

      expect(page).to have_content("You have signed up")
    end

    scenario "can't sign up without email address", js: true do
      visit "/"

      expect(page).not_to have_css ".sign_up_form"

      click_button "sign_up"
      within(".sign_up_form") do
        fill_in "Email", with: ""
        fill_in "Password", with: "randomletters"
        fill_in "Password confirmation", with: "randomletters"
        click_button "Sign Up"
      end

      expect(page).to have_content("Sign up failed")
    end

    scenario "can't sign up with different passwords", js: true do
      visit "/"

      expect(page).not_to have_css ".sign_up_form"

      click_button "sign_up"
      within(".sign_up_form") do
        fill_in "Email", with: "example@email.co.uk"
        fill_in "Password", with: "randomletters"
        fill_in "Password confirmation", with: "randomlett"
        click_button "Sign Up"
      end

      expect(page).to have_content("Sign up failed")
    end

    scenario "can't sign up with password less than 8 characters", js: true do
      visit "/"

      expect(page).not_to have_css ".sign_up_form"

      click_button "sign_up"
      within(".sign_up_form") do
        fill_in "Email", with: "example@email.co.uk"
        fill_in "Password", with: "random"
        fill_in "Password confirmation", with: "random"
        click_button "Sign Up"
      end

      expect(page).to have_content("Sign up failed")
    end
  end

  xscenario "the blogger can sign in" do
    Blogger.create( email: "example@email.co.uk", 
                    crypted_password: Sorcery::CryptoProviders::BCrypt.encrypt("randomletters", "asdasdastr4325234324sdfds") )
    visit "/"
    fill_in "email", with: "example@email.co.uk"
    fill_in "password", with: "randomletters"
    click_button "Sign in"

    expect(page).to have_button "New Article"
    expect(page).not_to have_button "Sign in"
  end

  context "after signing in the blogger returns to the" do
    xscenario "main page if started there" do
      visit "/"

      sign_in

      expect(current_path).to eq "/"
    end

    xscenario "article page if started there" do
      Article.create(title: "Example Title", content: "Hello World!!")
      
      visit "/articles/example-title"

      sign_in

      expect(current_path).to eq "/articles/example-title"
    end
  end

  xscenario "raises error if details are wrong" do
    visit "/"
    fill_in "email", with: "wrong.email@email.co.uk"
    fill_in "password", with: "wrong_password"
    click_button "Sign in"

    expect(page).to have_content "Wrong email or password, only try to sign in if your write the blog."
  end
end