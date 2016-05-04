class Comment < ActiveRecord::Base

  validates :name, presence: true
  validates :content, presence: true

  belongs_to :article

  def posted_at(time)
    difference = time - created_at

    if difference < 60
      "#{difference.to_i}s ago"
    elsif difference < (60 * 60)
      dif = (difference/(60)).to_i
      "#{dif} min#{"s" if dif > 1} ago"
    elsif difference < (60 * 60 * 24)
      dif = (difference/(60 * 60)).to_i
      "#{dif} hr#{"s" if dif > 1} ago"
    elsif difference < (60 * 60 * 24 * 30)
      dif = (difference/(60 * 60 * 24)).to_i
      "#{dif} day#{"s" if dif > 1} ago"
    elsif difference < (60 * 60 * 24 * 365)
      dif = (difference/(60 * 60 * 24 * 30)).to_i
      "#{dif} month#{"s" if dif > 1} ago"
    else
      dif = (difference/(60 * 60 * 24 * 365)).to_i
      "#{dif} year#{"s" if dif > 1} ago"
    end
  end
end
