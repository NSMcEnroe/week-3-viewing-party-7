require "rails_helper"

RSpec.describe "User Registration form" do
  it "creates new user with a password" do
    visit "/register"

    name = "Chuck"
    email = "chuck@ymail.com"
    password = "password123"

    fill_in :user_name, with: name
    fill_in :user_email, with: email
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: password

    click_on "Create New User"

    user = User.last

    expect(current_path).to eq(user_path(user))
  end

  it "rejects a new user if the user leaves any field blank" do
    visit "/register"

    name = ""
    email = ""
    password = ""

    fill_in :user_name, with: name
    fill_in :user_email, with: email
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: password

    click_on "Create New User"

    user = User.last

    expect(page).to have_content("Password can't be blank")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Email can't be blank")
  end

  it "rejects a new user if the passwords don't match" do
    visit "/register"

    name = "Chuck"
    email = "chuck@ymail.com"
    password = "hey"
    wrong_password = "you"

    fill_in :user_name, with: name
    fill_in :user_email, with: email
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: wrong_password

    click_on "Create New User"

    user = User.last

    expect(page).to have_content("Password confirmation doesn't match")
  end
end