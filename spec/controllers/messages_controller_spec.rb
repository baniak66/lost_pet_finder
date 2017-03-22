require 'rails_helper'

RSpec.describe MessagesController, type: :controller do

  let!(:announcement) { create :announcement }

  describe 'anonymous user' do

    before :each do
      sign_in nil
    end

    it "can't create message" do
      post :create, params: { announcement_id: announcement.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'logged user' do

    let!(:user) { create :user }
    before :each do
      sign_in user
    end

    let!(:params) do
      { params: {announcement_id: announcement.id,
        message: { content: "hello", user_id: user.id, announcement_id: announcement.id }}}
    end
    subject { post :create, params }

    it "can create message" do
      expect{ subject }.to change(Message,:count).by(1)
    end
    it "display notice" do
      subject
      expect(flash[:notice]).to eq 'Message created!'
    end
  end
end
