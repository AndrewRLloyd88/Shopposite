require 'rails_helper'

RSpec.feature "Visitor navigates to signup page", type: :feature, js: true do

  scenario "Incorrect Signup" do
    # ACT
    visit signup_path

      before_count = User.count

      fill_in 'user_name', with: ''
      fill_in 'user_email', with: "user@invalid"
      fill_in "user_password", with: "foo"
      fill_in "user_password_confirmation", with: "bar"


    # DEBUG
    save_screenshot

    click_button 'Create my account'

    # VERIFY
    after_count = User.count
    expect(before_count).to eq(after_count)
    expect(page).to have_content('The form contains 4 errors')
    expect(page).to have_css('div#error_explanation')
    expect(page).to have_css('div.alert.alert-danger')
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Email is invalid")
    expect(page).to have_content("Password confirmation doesn't match Password")
    expect(page).to have_content("Password is too short (minimum is 6 characters")
    save_screenshot
  end

  scenario "Valid Signup" do
    # ACT
    visit signup_path

      before_count = User.count

      fill_in 'user_name', with: 'Example User'
      fill_in 'user_email', with: "exampleuser@example.com"
      fill_in "user_password", with: "123456"
      fill_in "user_password_confirmation", with: "123456"


    # DEBUG
    save_screenshot

    click_button 'Create my account'

    # VERIFY
    after_count = User.count
    expect(after_count).to eq(before_count + 1)
    expect(page).to have_content('Example User')
    expect(page).to have_css('img.gravatar')
    expect(page).to have_content('Welcome to Shopposite Example User!')
    save_screenshot
  end
end