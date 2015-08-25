require 'page_magic'
require 'waitforit'

# module PageTransitions
#   def wait_for_page_to_change
#     before do
#       @current_url = session.current_url
#     end
#     after do
#       wait_until { @current_url!= session.current_url }
#     end
#   end
# end

class LoginPage
  include PageMagic

  text_field(:username, name: 'username')
  text_field(:password, name: 'password')
  button(:login_button, text: 'login_button')

  def login(user, pass)
    username.set user
    password.set pass
    login_button.click
  end
end