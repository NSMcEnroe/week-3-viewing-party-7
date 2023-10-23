require "rails_helper"

RSpec.describe "User Registration form" do
  it "creates new user with a password" do
    visit "/register"

    name = "Chuck"
    email = "chuck@ymail.com"
    password = "password123"

    fill_in :name, with: name
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password

    click_on "Create New User"

    expect(current_path).to eq(user_path)
  end
end