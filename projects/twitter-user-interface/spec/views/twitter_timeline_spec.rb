require 'app'

describe 'twitter_timeline.slim', :type => :feature do

  include Capybara::DSL

  Capybara.app = Twitter.new

  it 'displays the users twitter timeline' do

    visit '/timeline'

    expect(page).to have_content 'Mon Apr 20 20:49:20 +0000 2015'
    expect(page).to have_content 'Sat Jun 01 07:50:34 +0000 2013'
  end
end