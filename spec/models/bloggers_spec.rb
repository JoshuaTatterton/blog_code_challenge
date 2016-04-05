describe Blogger, type: :model do
  let!(:subject) { Blogger.create(username: "Username", email: "example@email.com", password: "randomletters") }

  it { should have_many :articles }
  it { should have_many :subscribers }

  it { should validate_presence_of(:username) }

  it "know its last article" do
    expect(subject.last_article).to eq nil

    article1 = subject.articles.create(title: "Example Title", content: "Don't show me!!")
    article2 = subject.articles.create(title: "Another Title", content: "Show Me!!")
    
    expect(subject.last_article).to eq article2
  end

  it "should change the updated_at when an article is added" do
    before = subject.updated_at

    subject.articles.create(title: "Example Title", content: "Hello World!!")

    after = subject.updated_at

    expect(before < after).to be_truthy
  end
end