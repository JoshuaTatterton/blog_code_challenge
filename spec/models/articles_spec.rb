require "rails_helper"

describe Article, type: :model do

  it { should validate_presence_of(:title) }
  it { should validate_uniqueness_of(:title) }

  it { is_expected.to have_many :comments }
  
end