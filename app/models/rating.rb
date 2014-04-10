class Rating < ActiveRecord::Base

  belongs_to :rater, class_name: "User"
  belongs_to :ratee, class_name: "User"
  belongs_to :apprenticeship

  validates :rater, presence: true
  validates :ratee, presence: true
  validates :apprenticeship, presence: true
  validates :rating, numericality: { greater_than_or_equal_to: 1 }
  validates :rating, numericality: { less_than_or_equal_to: 5 }
  validate :self_rating?

  def self_rating?
    if self.rater == self.ratee
      errors.add(:rater, "cannot rate self")
    end
  end

end
