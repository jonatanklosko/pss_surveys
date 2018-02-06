require "rails_helper"

RSpec.describe SurveysMailer, type: :mailer do
  describe "#send_survey" do
    let(:survey) { create :survey }
    let(:mail) { SurveysMailer.send_survey survey }

    it "renders the headers" do
      expect(mail.to).to eq [survey.competitor_email]
      expect(mail.subject).to match survey.competition.name
    end

    describe "body" do
      let(:body) { mail.html_part.body }

      it "includes competition name" do
        expect(body).to match survey.competition.name
      end

      it "includes survey url" do
        expect(body).to match edit_survey_url(survey)
      end

      context "competitor survey" do
        it "includes competitor welcome" do
          expect(body).to match "Drogi uczestniku"
        end
      end

      context "delegate survey" do
        let(:survey) { create :survey, delegate: true }
        let(:mail) { SurveysMailer.send_survey survey }
        let(:body) { mail.html_part.body }

        it "includes delegate welcome" do
          expect(body).to match "Drogi delegacie"
        end
      end
    end
  end
end
