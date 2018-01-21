require 'rails_helper'

RSpec.describe Survey, type: :model do
  let(:survey) { create :survey }

  describe "#secret_id" do
    it "is set for a new survey" do
      secret_id = Survey.new.secret_id
      expect(secret_id).to_not be_nil
      expect(secret_id).to be_an_instance_of String
    end

    it "is not overriden when loading a survey from the database" do
      expect(survey.secret_id).to eq survey.reload.secret_id
    end
  end
end
