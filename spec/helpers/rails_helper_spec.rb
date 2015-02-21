require 'rails_helper'

describe ReviewsHelper, :type => :helper do

  context '#star_rating' do
    it 'does nothing for not a number' do
      expect(helper.star_rating('N/A')).to eq 'N/A'
    end

    it 'returns five black stars for five' do
      expect(helper.star_rating(5)).to eq '★★★★★'
    end

    it 'returns three black stars and two white stars for three' do
      expect(helper.star_rating(3)).to eq '★★★☆☆'
    end

    it 'returns four black stars and one white star for 3.5' do
      expect(helper.star_rating(3.5)).to eq '★★★★☆'
    end
  end

# context '#time_ago' do
  
#   it 'returns 1 min ago if review left 1 minute ago' do

#   end

#   it 'returns 2 hours ago if review left 2 hours ago' do

#   end

#   it 'returns 4 horus ago if review left 4 days ago' do

#   end

#   it 'returns 1 month ago if review left 1 month ago' do

#   end

#   it 'returns 1 month ago if review left 1 month 4 days and 2 hours ago' do

#   end
# end
end