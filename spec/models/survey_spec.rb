require 'rails_helper'

RSpec.describe Survey, type: :model do
  describe "#secret_id" do
    it "is set for a new survey" do
      secret_id = Survey.new.secret_id
      expect(secret_id).to_not be_nil
      expect(secret_id).to be_an_instance_of String
    end
  end
end
