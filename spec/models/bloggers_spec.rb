describe Blogger, type: :model do
  let!(:subject) { Blogger.create(username: "Username", email: "example@email.com", password: "randomletters") }

  it { should have_many :articles }
  it { should have_many :subscribers }

  it { should validate_presence_of(:username) }

end