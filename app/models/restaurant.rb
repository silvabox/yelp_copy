class Restaurant < ActiveRecord::Base

  belongs_to :user
  has_many :reviews, dependent: :destroy
  validates :name, length: {minimum: 3}, uniqueness: true

  def average_rating
    return 'N/A' if reviews.none?
    reviews.average(:rating).to_i
  end

  def build_review(params, user)
    review = reviews.build(params)
    review.time_reviewed(Time.now)
    review.user = user
    p review
    review
  end

end
