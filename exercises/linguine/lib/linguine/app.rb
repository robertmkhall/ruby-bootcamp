require_relative 'linguine'

class App < Linguine

  page '/', '/home' do
    render('index', heading: 'Welcome To RobCorp')
  end

  page '/about' do
    render('about', heading: 'This is the website for RobCorp')
  end
end