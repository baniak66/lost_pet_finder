require "rails_helper"

RSpec.feature "Messages features", :type => :feature do

  given!(:user) { create :user, email: 'user@example.com', password: 'password', password_confirmation: 'password'}
  given!(:announcement) { create :announcement, title: "Where is my cat", user: user, anno_type: "lost", animal: "dog", place: "opole" }

  context "Logged user" do
    before :each do
      visit root_path
      click_on "Login"
      fill_in "user_email", with: "user@example.com"
      fill_in "user_password", with: "password"
      click_button "Log in"
      expect(page).to have_content("Signed in successfully.")
    end

    scenario "creates a message" do
      click_on "Details"

      expect(page).to have_content("Where is my cat")
      fill_in "message_content", with: "Lost puppy"
      click_on "Send"

      expect(page).to have_content("Lost puppy")
      expect(page).to have_content("user@example.com")
    end
  end

  context "Anoymous user" do

    scenario "try to add message" do
      visit root_path
      click_on "Details"
      expect(page).to have_content("Where is my cat")
      expect(page).to have_content("Please login to add message ...")
      expect(page).to have_no_link("Send")
    end

  end

end
