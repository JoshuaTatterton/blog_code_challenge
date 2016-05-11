describe Comment, type: :model do

  it { should validate_presence_of(:name) }
  
  it { should validate_presence_of(:content) }

  it { is_expected.to belong_to :article }

  context "displays the time created at as" do
    let(:subject) { Comment.create(name: "anon", content: "comment") }
    
    it "seconds ago" do
      time = subject.created_at + 26
      expect(subject.posted_at(time)).to eq "26s ago" 
    end

    it "minutes ago" do
      time = subject.created_at + (31 * 60)
      expect(subject.posted_at(time)).to eq "31 mins ago" 
    end

    it "hours ago" do
      time = subject.created_at + (19 * 60 * 60)
      expect(subject.posted_at(time)).to eq "19 hrs ago" 
    end

    it "days ago" do
      time = subject.created_at + (29 * 60 * 60 * 24)
      expect(subject.posted_at(time)).to eq "29 days ago" 
    end

    it "months ago" do
      time = subject.created_at + (11 * 60 * 60 * 24 * 30)
      expect(subject.posted_at(time)).to eq "11 months ago" 
    end

    it "years ago" do
      time = subject.created_at + (2 * 60 * 60 * 24 * 365)
      expect(subject.posted_at(time)).to eq "2 years ago" 
    end
  end
end