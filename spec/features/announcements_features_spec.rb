require "rails_helper"

RSpec.feature "Announcements features", :type => :feature do

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

    scenario "creates a new announcement" do
      click_on "New announcement"

      expect(page).to have_content("New announcement")
      fill_in "announcement_title", with: "Lost puppy"
      fill_in "announcement_description", with: "Help me to find my puppy"
      fill_in "announcement_place", with: "Opole"
      choose("Lost")
      choose("Dog")
      click_on "Create Announcement"

      expect(page).to have_content("Announcement created.")
      expect(page).to have_content("Lost puppy")
    end

    scenario "edit announcement" do
      expect(page).to have_content("Where is my cat")

      click_on "Details"
      click_on "Edit"

      fill_in "announcement_title", with: "Where is my dog"
      fill_in "announcement_description", with: "Help me to find my puppy"
      fill_in "announcement_place", with: "Opole"
      choose("Lost")
      choose("Dog")
      click_on "Update Announcement"

      expect(page).to have_content("Announcement updated.")
      expect(page).to have_content("Where is my dog")
    end

    scenario "close announcement" do
      expect(page).to have_content("Where is my cat")

      click_on "Your announcements"
      click_on "Close"

      expect(page).to have_content("Closed")
      expect(page).to have_no_link("Close")
    end

    scenario "delete announcement" do
      expect(page).to have_content("Where is my cat")

      click_on "Details"
      click_on "Delete"

      expect(page).to have_content("Announcement deleted.")
      expect(page).to have_no_content("Where is my cat")
    end
  end

  context "Anoymous user" do

    before :each { visit root_path }
    scenario "try to create announcement" do
      expect(page).to have_no_link("New announcement")
    end

    scenario "try to display users announcements" do
      expect(page).to have_no_link("Your announcements")
    end

    scenario "try to edit or delete announcement" do
      click_on "Details"
      expect(page).to have_content("Where is my cat")
      expect(page).to have_no_link("Edit")
      expect(page).to have_no_link("Delete")
    end

  end

end
