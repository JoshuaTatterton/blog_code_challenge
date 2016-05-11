feature "blogger" do

  scenario "displays message if there are no bloggers" do
    visit "/"

    expect(page).to have_content "Oops there are no articles here."
    expect(page).to have_content "Why don't you become a blogger and write the first one."
  end

  scenario "has a button in the nav bar to take a blogger to their page" do
    visit "/"

    expect(page).not_to have_link "My blog"

    sign_up

    visit "/"

    expect(page).to have_link "My blog"

    click_link "My blog"

    expect(current_path).to eq "/bloggers/#{Blogger.last.slug}/articles"
  end

  context "in the nav bar" do
    let!(:blogger) { Blogger.create(username: "My Username", email: "example@email.com", password: "randomletters") }

    scenario "there are buttons to do things" do
      visit "/bloggers/my-username/articles"
      within(".o-nav") do
        expect(page).to have_link "Home"
        expect(page).to have_button "Sign in"
        expect(page).to have_link "Sign in"
        expect(page).to have_link "Sign up"
      end
      sign_up
      visit "/bloggers/my-username/articles"
      within(".o-nav") do
        expect(page).to have_link "Home"
        expect(page).to have_link "My blog"
        expect(page).to have_link "Sign out"
      end
    end
  end

  context "on the home page" do

    let!(:blogger) { Blogger.create(username: "My Username", email: "example@email.com", password: "randomletters") }

    scenario "there is a link to the article page" do
      article = blogger.articles.create(title: "Example Title", content: "Ok show me!!")

      visit "/"

      expect(page).to have_link "#{article.id}"

      click_link "#{article.id}"

      expect(current_path).to eq "/bloggers/#{blogger.slug}/articles/#{article.slug}"
    end

    scenario "it displays the most recent blogs posts" do
      article1 = blogger.articles.create(title: "Example Title", content: "Ok show me!!")
      article2 = blogger.articles.create(title: "Another Title", content: "Show Me!!")
      
      visit "/"

      expect(page).to have_content article1.title
      expect(page).to have_content article1.content
      expect(page).to have_content "-#{article1.blogger.username}"

      expect(page).to have_content article2.title
      expect(page).to have_content article2.content
      expect(page).to have_content "-#{article2.blogger.username}"
    end
    
  end

  scenario "a bloggers url has their username in it" do
    blogger = Blogger.create(username: "My Username", email: "example@email.com", password: "randomletters")
    article = blogger.articles.create(title: "Example Title", content: "Some Content!!")
    
    visit "/"

    click_link "#{article.id}"
    click_link "< My Username"

    expect(current_path).to eq "/bloggers/my-username/articles"
  end

  context "a prospective blogger" do
    scenario "can sign up" do
      visit "/"

      click_link "Sign up"

      within(".o-main") do
        fill_in "Username", with: "My Username"
        fill_in "Email", with: "example@email.co.uk"
        fill_in "blogger_password", with: "randomletters"
        fill_in "Password confirmation", with: "randomletters"
        click_button "Sign up"
      end

      expect(page).to have_content("You have signed up")
    end

    scenario "can cancel signing up" do
      visit "/"

      click_link "Sign up"

      click_link "Cancel"

      expect(current_path).to eq "/"
    end

    scenario "can't sign up without username" do
      visit "/"

      sign_up(username: "")

      expect(page).to have_content("Sign up failed")
    end

    scenario "can't sign up with a already used username (case insensitive)" do
      Blogger.create(username: "MyUsername", email: "example@email.co.uk", password: "randomletters")
      visit "/"

      sign_up(username: "myusername", email: "another@email.com")

      expect(page).to have_content("Sign up failed")
    end

    scenario "can't sign up without email address" do
      visit "/"

      sign_up(email: "")

      expect(page).to have_content("Sign up failed")
    end

    scenario "can't sign up with a already used email address (case insensitive)" do
      Blogger.create(username: "Username", email: "example@email.co.uk", password: "randomletters")
      visit "/"

      sign_up(username: "another", email: "Example@Email.co.uk")

      expect(page).to have_content("Sign up failed")
    end

    scenario "can't sign up with different passwords" do
      visit "/"

      sign_up(password_confirmation: "randomlett")

      expect(page).to have_content("Sign up failed")
    end

    scenario "can't sign up with password less than 8 characters" do
      visit "/"

      sign_up(password: "random", password_confirmation: "random")

      expect(page).to have_content("Sign up failed")
    end
  end

  context "an existing blogger" do
    before(:each) do
      visit "/"

      sign_up
    end

    scenario "who's signed in can sign out" do
      expect(page).to have_link("Sign out")

      click_link "Sign out"

      expect(page).to have_content("You have signed out")
      expect(page).not_to have_link("Sign out")
      expect(current_path).to eq "/"
    end

    context "can sign in" do
      scenario "through the sign in page (for smaller pages)" do
        click_link "Sign out"

        expect(page).to have_link("Sign in")

        click_link "Sign in"

        within(".o-main") do
          fill_in "Email", with: "example@email.co.uk"
          fill_in "Password", with: "randomletters"
          click_button "Sign in"
        end

        expect(page).to have_content("You have signed in")
        expect(page).not_to have_button("Sign in")
        expect(page).to have_css("label", text: "New Article")
      end
      scenario "can cancel signing in on the sign in page" do
        click_link "Sign out"

        click_link "Sign in"

        click_link "Cancel"

        expect(current_path).to eq "/"
      end

      scenario "directly via the nav bar (for larger pages)" do
        click_link "Sign out"

        fill_in "Email", with: "example@email.co.uk"
        fill_in "Password", with: "randomletters"
        click_button "Sign in"

        expect(page).to have_content("You have signed in")
        expect(page).not_to have_button("Sign in")
        expect(page).to have_css("label", text: "New Article")
      end
    end

    scenario "can't sign in if details are incorrect" do
      click_link "Sign out"

      click_link "Sign in"
      
      within(".o-main") do
        fill_in "Email", with: "example@email.co.uk"
        fill_in "Password", with: "lettersrandom"
        click_button "Sign in"
      end
      
      expect(page).to have_content("Sign in failed")
      expect(page).to have_button("Sign in")
      expect(page).not_to have_button("New Article")
    end    
  end

end