require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email)}
    it { should validate_presence_of(:password_digest)}
    it { should have_secure_password }

  end

  it "should be able to encrypt the password" do

    user = User.create(name: "Meg", email: "meg@test.com", password: "password123", password_confirmation: "password123")

    expect(user).to_not have_attribute(:password)
    expect(user.password_digest).to_not eq("password123")
  end 
  
  describe "#passwords match" do
    it "can confirm password and password confirmation are the same" do
      user = User.new(name: "Al", email: "al@a.com", password: "123", password_confirmation: "123")

      expect(user).to be_valid
    end

    it "rejects the user if password and password_confirmation are not the same" do
      user = User.new(name: "Al", email: "al@a.com", password: "123", password_confirmation: "124")

      expect(user).to_not be_valid
    end
  end
end
