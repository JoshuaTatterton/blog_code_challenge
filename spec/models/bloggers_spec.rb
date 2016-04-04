describe Blogger, type: :model do

  it { should have_many :articles }
  it { should have_many :subscribers }

  it { should validate_presence_of(:username) }

end