module Helpers

  def sign_in
    within(".main") do
      fill_in "email", with: "example@email.co.uk"
      fill_in "password", with: "randomletters"
      click_button "Sign in"
    end
  end

  def write_article(options={})
    options[:option] ||= "markdown"
    click_button "new_article"
    within(".article_writer") do
      fill_in "article_title", with: "Example Title"
      choose "article_option_#{options[:option]}"
      if options[:option] == "markdown"
        fill_in "article_content", with: "Hello World!!"
      elsif options[:option] == "wysiwyg"
        fill_in_ckeditor "wysiwyg_content", with: "Hello World!!"
      end
      click_button "Post"
    end
  end

  def edit_article
    click_button "Edit Article"
    fill_in "article_content", with: "Hello New World!!"
    click_button "Edit"
  end

  def delete_article
    click_button "Edit Article"
    click_link "Delete"
  end

  def write_comment
    click_button "Comment"
    fill_in "comment_name", with: "MyName"
    fill_in "comment_content", with: "I like this"
    click_button "Post Comment"
  end

  def visiter_subscribe
    fill_in "subscriber_email", with: "example@email.co.uk"
    click_button "Subscribe"
  end

  def allow_run_sidekiq
    Sidekiq::Testing.inline!
  end

  def sign_up(options={})
    options[:username] ||= "MyUsername"
    options[:email] ||= "example@email.co.uk"
    options[:password] ||= "randomletters"
    options[:password_confirmation] ||= "randomletters"

    click_link "Sign up"

    within(".main") do
      fill_in "Username", with: options[:username]
      fill_in "Email", with: options[:email]
      fill_in "Password", with: options[:password]
      fill_in "Password confirmation", with: options[:password_confirmation]
    end

    click_button "Sign up"
  end

  def fill_in_ckeditor(locator, opts)
    content = opts.fetch(:with).to_json
    page.execute_script <<-SCRIPT
      CKEDITOR.instances['#{locator}'].setData(#{content});
      $('textarea##{locator}').text(#{content});
    SCRIPT
  end

end