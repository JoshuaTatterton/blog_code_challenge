describe Subscriber, type: :model do
  let(:blogger) { Blogger.create(email: "example@email.co.uk", password: "randomletters") }
  let(:subject) { blogger.subscribers.create(email: "example@email.co.uk") }

  it { should validate_presence_of(:email) }

  it { should belong_to :blogger }

  let(:article) { double :article,  title: "Example Title", 
                                    content: "Hello World!!", 
                                    slug: "example-title",
                                    blogger: 1}
  
  it "sends email to subscribers" do
    expect { subject.send_email(article) }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

end