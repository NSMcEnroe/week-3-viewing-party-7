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
end