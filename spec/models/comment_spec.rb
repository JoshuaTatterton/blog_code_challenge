describe Comment, type: :model do

  it { should validate_presence_of(:name) }
  
  it { should validate_presence_of(:content) }

  it { is_expected.to belong_to :article }

end