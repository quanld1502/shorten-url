require "rails_helper"

RSpec.describe ShortenUrlService do
  describe 'when valid slug' do
    it 'given slug to 8 characters' do
      expect(ShortenUrlService.execute(:shorten_url, { url: 'http://abc.com.vn/long_url' }).length).to eq(8)
    end

    it 'given slug unique' do
      code_1 = ShortenUrlService.execute(:shorten_url, { url: 'http://abc.com.vn/long_url' })
      code_2 = ShortenUrlService.execute(:shorten_url, { url: 'http://abc.com.vn/long_url' })

      expect(code_1).to_not eq(code_2)
    end
  end
end