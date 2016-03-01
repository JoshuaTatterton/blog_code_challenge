module Helpers

  def sign_in
    fill_in "email", with: "example@email.co.uk"
    fill_in "password", with: "randomletters"
    click_button "Sign in"
  end

  def write_article
    click_button "new_article"
    fill_in "article_title", with: "Example Title"
    fill_in "article_content", with: "Hello World!!"
    click_button "Post Article"
  end

  def edit_article
    click_button "Edit Article - Example Title"
    fill_in "article_content", with: "Hello New World!!"
    click_button "Edit Article"
  end

  def delete_article
    click_button "Edit Article - Example Title"
    click_link "Delete Article"
  end
end