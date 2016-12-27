require 'spec_helper'

RSpec.describe User, type: :model do
  context "validations" do
    it "is invalid without a first name" do
      expect(User.create(name: nil, email: "ryder.carroll@bujo.com", password: "this is a test")).to_not be_valid
    end

    it "is invalid without a last name" do
      expect(User.create(name: nil, email: "ryder.carroll@bujo.com", password: "this is a test")).to_not be_valid
    end

    it "is invalid without an email" do
      expect(User.create(name: "Harry Potter", email: nil, password: "this is a test")).to_not be_valid
    end

    it "is invalid without a username" do
      expect(User.create(name: "Ryder Carroll", email: "ryder.carroll@bujo.com", password: nil)).to_not be_valid
    end

    it "is invalid without a password" do
      expect(User.create(first_name: "Ryder", last_name: "Carroll", username: "rcarroll", email: "ryder.carroll@bujo.com", password: nil)).to_not be_valid
    end
  end

  context "attributes" do
    let(:user) {User.create(name: "Ryder Carroll", email: "ryder.carroll@bujo.com", password: "this is a test")}
    it "has a name" do
      expect(user.name).to eq("Ryder Carroll")
    end

    it "has an email" do
      expect(user.email).to eq("ryder.carroll@bujo.com")
    end

    it "responds to authenticate method from has_secure_password" do
      @user = User.create(User.create(first_name: "Ryder", last_name: "Carroll", username: "rcarroll", email: "ryder.carroll@bujo.com", password: "this is a test")
      expect(@user.authenticate("test")).to be_truthy
    end
  end
end
