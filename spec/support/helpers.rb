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

  def write_comment
    click_button "Comment"
    fill_in "comment_name", with: "MyName"
    fill_in "comment_content", with: "I like this"
    click_button "Post Comment"
  end

  def visiter_subscribe
    click_button "Subscribe"
    fill_in "subscriber_email", with: "example@email.co.uk"
    click_button "Become a Subscriber"
  end

end