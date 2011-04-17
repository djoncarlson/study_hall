require "spec_helper"

describe Notifier do
  describe "attendance_taken" do
    let(:mail) { Notifier.attendance_taken }

    it "renders the headers" do
      mail.subject.should eq("Attendance taken")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
