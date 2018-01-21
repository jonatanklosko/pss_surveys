require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  describe ".find_or_initialize_from_wca_data" do
    let(:user_data) {{
      id: 3,
      wca_id: "2013KOSK01",
      name: "Jonatan Kłosko",
      avatar: {
        url: "http://example.com/avatar.png",
        thumb_url: "http://example.com/avatar_thumb.png"
      }
    }}

    context "when the user doesn't exist" do
      it "initializes a user from parsed json data" do
        user = User.find_or_initialize_from_wca_data(user_data)
        expect(user.wca_user_id).to eq user_data[:id]
        expect(user.wca_id).to eq user_data[:wca_id]
        expect(user.name).to eq user_data[:name]
        expect(user.avatar_thumb_url).to eq user_data[:avatar][:thumb_url]
      end
    end

    context "when the user already exists" do
      let!(:user) { create :user, wca_user_id: 3, avatar_thumb_url: nil }

      it "assigns attributes to the existing user" do
        User.find_or_initialize_from_wca_data(user_data).save!
        expect(user.reload.avatar_thumb_url).to eq user_data[:avatar][:thumb_url]
      end
    end
  end
end
