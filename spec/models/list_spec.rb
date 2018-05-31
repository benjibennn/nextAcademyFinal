require 'rails_helper'

RSpec.describe List, type: :model do

  context "validations" do

      describe "can be created when all attributes are present" do
      When(:user){User.create(first_name: "ben",last_name: "bennn", email: "bob@bob.com", password: "5" )}

      When(:list) { List.create(
        name: "hello",
        description: "this is a description",
        user_id: "1"
      )
    }
      Then { list.valid? == true }
    end
  
      describe "cannot be created without a name" do
        When(:list) { List.create(description: "this is a description", user_id:5) }
        Then { list.valid? == false }
      end

      describe "cannot be created without a description" do
        When(:list) { List.create(name: "Ben",user_id: 5) }
        Then { list.valid? == false }
      end      
  end

   describe List do
        it "should have one user" do
          t = List.reflect_on_association(:user)
          expect(t.macro).to eq(:belongs_to)
        end
      end

end