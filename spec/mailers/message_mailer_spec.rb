require "rails_helper"

RSpec.describe "Message mailer", :type => :mailer do

  describe "notify" do
    let!(:user) { create :user, email: "user@example.com" }
    let!(:announcement) { create :announcement, user: user }
    let(:mail) { MessageMailer.new_message_email(user).deliver_now }

    it "renders the headers" do
      expect(mail.subject).to eq("New message on your announcement")
      expect(mail.to).to eq(["user@example.com"])
      expect(mail.from).to eq(["info@lostpetfinder.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hello user@example.com!")
      expect(mail.body.encoded).to match("We noticed new message on your annoucement.")
    end
  end
end
