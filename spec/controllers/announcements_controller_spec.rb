require 'rails_helper'

RSpec.describe AnnouncementsController, type: :controller do

  describe 'anonymous user' do
    let(:announcement) { create :announcement }

    before :each do
      sign_in nil
    end

    let(:params) do
      { params: { id: announcement.id, announcement: { title: "new title"} } }
    end

    context 'retrives list' do
      let!(:announcements) { create_list :announcement, 10 }
      it 'of announcements' do
        get :index
        expect(response).to be_success
        expect(Announcement.all.length).to eq(10)
      end
    end

    it 'retrives specific announcement' do
      get :show, params: { id: announcement.id }
      expect(response).to be_success
    end

    it "can't display new announcement form" do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end

    it "can't add announcement" do
      post :create
      expect(response).to redirect_to(new_user_session_path)
    end

    it "can't display announcement edit form" do
      get :edit, params: { id: announcement.id }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "can't update announcement" do
      put :update, params
      expect(response).to redirect_to(new_user_session_path)
    end

    it "can't delete announcement" do
      delete :destroy, params: { id: announcement.id }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "can't close announcement" do
      post :close, params: { id: announcement.id }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "can't display user announcements" do
      get :users
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'logged user' do

    let!(:user){ create :user }

    before :each do
      sign_in user
    end

    let!(:params) do
      { params: { announcement: { title: "title", description: "description",
        animal: "dog", anno_type: "lost", place: "opole" }
        }
      }
    end
    subject { post :create, params }

    it "can display new announcement form" do
      get :new
      expect(response).to be_success
    end

    it "can display users announcements page" do
      get :users
      expect(response).to be_success
    end

    context "try to create announcement" do
      it "successfully" do
        expect{ subject }.to change(Announcement,:count).by(1)
      end
      it "display success notice" do
        subject
        expect(flash[:notice]).to eq 'Announcement created.'
      end
    end

    describe "try to delete action" do
      let(:params) do
        { params: { id: announcement.id } }
      end
      subject { delete :destroy, params }

      context "author" do
        let!(:announcement) { create :announcement, user: user }

        it "can delete announcement" do
          expect{ subject }.to change(Announcement,:count).by(-1)
        end
      end

      context "not author" do
        let!(:author) { create :user }
        let!(:announcement) { create :announcement, user: author }

        it "can't delete announcement" do
          expect{ subject }.to_not change(Announcement, :count)
        end
      end
    end

    describe "try to update action" do
      let(:params) do
        { params: { id: announcement.id, announcement: { title: "new title"} } }
      end
      subject { put :update, params }

      context "author" do
        let!(:announcement) { create :announcement, user: user }

        it "can update announcement" do
          subject
          expect(flash[:notice]).to eq 'Announcement updated.'
          expect(announcement.reload.title).to eq 'new title'
        end
      end

      context "not author" do
        let!(:author) { create :user }
        let!(:announcement) { create :announcement, user: author }

        it "can't update announcement" do
          subject
          expect(flash[:error]).to eq 'Action restricted only for announcement owner'
        end
      end
    end

    describe "try to close announcement" do
      let(:params) do
        { params: { id: announcement.id } }
      end
      subject { post :close, params }

      context "author" do
        let!(:announcement) { create :announcement, user: user }

        it "can close announcement" do
          subject
          expect(announcement.reload.open).to eq(false)
        end
      end

      context "not author" do
        let!(:author) { create :user }
        let!(:announcement) { create :announcement, user: author }

        it "can't close announcement" do
          subject
          expect(announcement.reload.open).to eq(true)
          expect(flash[:error]).to eq 'Action restricted only for announcement owner'
        end
      end
    end
  end
end
