require 'spec_helper'

describe User, type: :model do
  context "validations" do
    it "is invalid without a first name" do
      expect(User.create(:first_name => nil, last_name: "Carroll", username: "rcarroll", email: "ryder.carroll@bujo.com", password: "this is a test")).to_not be_valid
    end

    it "is invalid without a last name" do
      expect(User.create(:first_name => "Ryder", last_name: nil, username: "rcarroll", email: "ryder.carroll@bujo.com", password: "this is a test")).to_not be_valid
    end

    it "is invalid without an email" do
      expect(User.create(:first_name => "Ryder", last_name: "Carroll", username: "rcarroll", email: nil, password: "this is a test")).to_not be_valid
    end

    it "is invalid without a username" do
      expect(User.create(first_name: "Ryder", last_name: "Carroll", username: nil, email: "ryder.carroll@bujo.com", password: "this is a test")).to_not be_valid
    end

    it "is invalid without a password" do
      expect(User.create(first_name: "Ryder", last_name: "Carroll", username: "rcarroll", email: "ryder.carroll@bujo.com", password: nil)).to_not be_valid
    end
  end

  context "attributes" do
    let(:user) {User.create(first_name: "Ryder", last_name: "Carroll", email: "ryder.carroll@bujo.com", username: "rcarroll", password: "this is a test")}
    it "has a first name" do
      expect(user.first_name).to eq("Ryder")
    end

    it "has a last name" do
      expect(user.last_name).to eq("Carroll")
    end

    it "has an email" do
      expect(user.email).to eq("ryder.carroll@bujo.com")
    end

    it "has a username" do
      expect(user.username).to eq("rcarroll")
    end

    it "responds to authenticate method from has_secure_password" do
      @user = User.create(first_name: "Ryder", last_name: "Carroll", username: "rcarroll", email: "ryder.carroll@bujo.com", password: "this is a test")
      expect(@user.authenticate("this is a test")).to be_truthy
    end
  end
end
