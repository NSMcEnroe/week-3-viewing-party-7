require "rails_helper"

RSpec.describe "Loggging In" do
  it "can log in with valid credentials" do
    user = User.create(name: "Weez", email: "w@gmail.com", password: "password")

    visit "/"

    click_on "Log In"

    expect(current_path).to eq(login_path)

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on "Log In"

    expect(current_path).to eq(user_path(user))
  end
  it "can reject a log in with invalid credentials" do
    user = User.create(name: "Weez", email: "w@gmail.com", password: "password")

    visit "/"

    click_on "Log In"

    expect(current_path).to eq(login_path)

    fill_in :email, with: user.email
    fill_in :password, with: "wrong"

    click_on "Log In"

    expect(page).to have_content("Try again.")
    expect(current_path).to eq(login_path)
  end
end