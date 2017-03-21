require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :content }
    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_presence_of :announcement_id }
  end

  describe 'database columns' do
    it { should have_db_column :content }
    it { should have_db_column :user_id }
    it { should have_db_column :announcement_id }
  end

  describe 'associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :announcement }
  end
end
