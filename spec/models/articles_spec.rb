describe Article, type: :model do

  it { should validate_presence_of(:title) }
  it { should validate_uniqueness_of(:title) }

  it { should have_many :comments }
  it { should belong_to :blogger }

end