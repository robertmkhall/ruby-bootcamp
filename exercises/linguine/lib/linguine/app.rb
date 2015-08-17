require_relative 'linguine'
require 'haml'

class App < Linguine

  page '/' do
    render('index', {heading: 'Welcome To RobCorp'})
  end

  page '/about' do
    render('about', {heading: 'This is the website for RobCorp'})
  end

  def unknown_url(url)
    render('unknown_url', {content: "Url '#{url}' is not recognised"})
  end
end