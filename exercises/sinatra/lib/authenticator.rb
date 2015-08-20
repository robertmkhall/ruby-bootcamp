class Authenticator

  USERNAME = 'robertmkhall'
  PASSWORD = 'password'

  def authenticate(username, password)
    username == USERNAME && password == PASSWORD
  end
end