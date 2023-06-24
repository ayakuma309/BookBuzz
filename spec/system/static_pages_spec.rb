require 'rails_helper'

RSpec.describe 'StaticPages', type: :system do
  before do
    driven_by :selenium_chrome_headless
  end

  describe 'トップページの検証' do
    it 'StaticPages#top という文字列が表示される' do
      visit '/'

      expect(page).to have_content('StaticPages#top')
    end
  end
end
