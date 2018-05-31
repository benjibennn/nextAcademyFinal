require 'rails_helper'

RSpec.describe User, type: :model do

  context "validations" do

      describe "can be created when all attributes are present" do
      When(:user) { User.create(
        first_name: "ben",
        email: "asdasdasdasdasdasasdasdsadsa@c.com",
        password: "123456",
      )}
      Then { 
        user.valid? == true }
    end
  end

      describe "cannot be created without a name" do
        When(:user) { User.create(email: "ben@ben.com", password: "123456", password_confirmation: "123456") }
        Then { user.valid? == false }
      end

      describe "cannot be created without a email" do
        When(:user) { User.create(name: "Ben", password: "123456", password_confirmation: "123456") }
        Then { user.valid? == false }
      end

      describe User do
        it "should have many list" do
          t = User.reflect_on_association(:list)
          expect(t.macro).to eq(:has_many)
        end
      end
end