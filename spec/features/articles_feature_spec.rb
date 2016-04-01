require "rails_helper"

feature "blog" do
  scenario "message is displayed when there are no blog posts" do
    visit "/"

    expect(page).to have_content "No blog posts have been made."
  end

  scenario "when a blog post has been created the article is displayed" do
    Article.create(title: "Example Title", content: "Hello World!!")

    visit "/"

    expect(page).to have_content "Hello World!!"
    expect(page).not_to have_content "No blog posts have been made."
  end

  context "on the main page while signed in as a blogger" do
    before(:each) do
      visit "/"
      sign_in
    end

    scenario "articles can be written", js: true do
      click_button "new_article"
      fill_in "article_title", with: "Example Title"
      fill_in "article_content", with: "Hello World!!"
      click_button "Post Article"

      expect(page).to have_content "Example Title"
      expect(page).to have_content "Hello World!!"
    end

    context "articles can be" do
      before(:each) do
        write_article
      end

      scenario "edited", js: true do
        click_button "Edit Article - Example Title"
        fill_in "article_content", with: "Hello New World!!"
        click_button "Edit Article"

        expect(page).to have_content "Hello New World!!"
      end

      scenario "deleted", js: true do
        click_button "Edit Article - Example Title"
        click_link "Delete Article"

        expect(page).not_to have_content "Hello World!!"
      end
    end

    scenario "you go back to the same page as before you edited", js: true do
      visit "/articles"

      write_article

      edit_article

      expect(current_path).to eq "/articles"
    end
  end

  context "articles" do
    before(:each) do
      visit "/"

      sign_in

      write_article
    end

    scenario "have their own named page", js: true do
      visit "/"
      click_link "Example Title"

      wait(2.seconds).for { current_path }.not_to eq "/"

      expect(current_path).to eq "/articles/example-title"     
    end

    scenario "are displayed on their own page", js: true do
      visit "/articles/example-title"

      expect(page).to have_content "Example Title"
      expect(page).to have_content "Hello World!!"
    end

    context "on their own page while signed in" do
      scenario "can be edited by the blogger", js: true do
        visit "/articles/example-title"

        edit_article

        expect(page).to have_content "Hello New World!!"
      end

      scenario "you go back to the same page as before you edited", js: true do
        visit "/articles/example-title"

        edit_article

        expect(current_path).to eq "/articles/example-title"
      end

      scenario "can be deleted by the blogger", js: true do
        visit "/articles/example-title"

        delete_article

        expect(page).not_to have_content "Example Title"
        expect(page).not_to have_content "Hello World!!"
      end
    end
  end

  context "emails are sent to subscribers" do
    scenario " when a new article is posted", js: true do
      visit "/"

      visiter_subscribe

      sign_in

      expect { write_article }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  context "raises error when" do
    before(:each) do
      visit "/"
      
      sign_in
    end

    scenario "title is empty", js: true do
      click_button "new_article"
      fill_in "article_title", with: ""
      fill_in "article_content", with: "Hello World!!"
      click_button "Post Article"

      expect(page).to have_content "Title can't be blank"
    end

    scenario "title is already used", js: true do
      write_article

      write_article

      expect(page).to have_content "Title has already been taken"
    end
  end
  context "there is a home button" do
    before(:each) do
      visit "/"

      sign_in

      write_article
    end

    scenario "in the nav bar", js: true do
      expect(page).to have_link "Home"

      click_link "Example Title"

      expect(page).to have_link "Home"
    end
    
    scenario "which takes you back to the root", js: true do
      click_link "Example Title"
      click_link "Home"

      wait(2.seconds).for { current_path }.not_to eq "/articles/example-title"
      
      expect(current_path).to eq "/"
    end
  end
end