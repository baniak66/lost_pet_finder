require 'rails_helper'

RSpec.describe Announcement, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :description }
    it { is_expected.to validate_presence_of :animal }
    it { is_expected.to validate_presence_of :anno_type }
    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_presence_of :place }
  end

  describe 'database columns' do
    it { should have_db_column :title }
    it { should have_db_column :description }
    it { should have_db_column :open }
    it { should have_db_column :animal }
    it { should have_db_column :anno_type }
    it { should have_db_column :user_id }
    it { should have_db_column :place }
    it { should have_db_column :latitude }
    it { should have_db_column :longitude }
  end

  describe 'associations' do
    it { is_expected.to have_many :messages }
    it { is_expected.to belong_to :user }
  end
end
