class Review < ActiveRecord::Base

  include ActionView::Helpers::DateHelper
  
  belongs_to :user
  belongs_to :restaurant

  validates :rating, inclusion: (1..5)

  def time_reviewed(time)
    time_ago_in_words(time)
  end
end
