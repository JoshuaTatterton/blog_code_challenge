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

  context "can display the search content" do
    it "for when it is markdown content" do
      subject = Article.create(title: "Example Title", content: "Don't show me!!", option: "markdown")

      expect(subject.search_content).to eq subject.content.downcase.gsub(" ", "")
    end

    it "for when it is wysiwyg content" do
      subject = Article.create(title: "Example Title", wysiwyg_content: "Don't show me!!", option: "wysiwyg")

      expect(subject.search_content).to eq subject.wysiwyg_content.downcase.gsub(" ", "")
    end
  end

  it "can display the search title" do
    subject = Article.create(title: "Example Title", wysiwyg_content: "Don't show me!!", option: "wysiwyg")

    expect(subject.search_title).to eq subject.title.downcase.gsub(" ", "")
  end

end