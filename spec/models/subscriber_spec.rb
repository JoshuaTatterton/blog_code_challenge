require "rails_helper"

describe Subscriber, type: :model do

  it { should validate_presence_of(:email) }

  let(:article) { double :article, title: "Example Title", content: "Hello World!!", slug: "example-title"}
  
  it "sends email to subscribers" do
    allow(subject).to receive(:email) { "example@email.co.uk" }
    expect { subject.send_email(article) }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

end