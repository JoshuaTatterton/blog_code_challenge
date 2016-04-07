describe Article, type: :model do

  it { should validate_presence_of(:title) }
  it { should validate_uniqueness_of(:title) }

  it { should have_many :comments }
  it { should belong_to :blogger }

  it "can say whether it is written in markdown" do
    subject = Article.create(title: "Example Title", content: "Don't show me!!", option: "markdown")

    expect(subject.markdown?).to be_truthy
    expect(subject.wysiwyg?).to be_falsey
  end

  it "can say whether it is written in wysiwyg" do
    subject = Article.create(title: "Example Title", content: "Don't show me!!", option: "wysiwyg")

    expect(subject.wysiwyg?).to be_truthy
    expect(subject.markdown?).to be_falsey
  end

end