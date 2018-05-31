require 'rails_helper'

RSpec.describe "sessions/new.html.erb", type: :view do
  
  describe "GET '/login' - from API", :type => :feature do
    it 'shows Welcome (insert_name)!' do
      visit('http://localhost:3000/login')
      expect(page).to have_content("Do-To-List Home (current) Log in Email Password Sign in with Google")
      puts 'it works'
    end
  end


end