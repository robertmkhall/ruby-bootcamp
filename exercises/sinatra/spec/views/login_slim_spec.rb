require_relative '../spec_helper'

describe 'login.slim' do

  include_context :slim_templates

  subject(:session) { LoginPage.new(render) }

  it 'displays the login fields' do
    expect(page).to have_field('username')
    expect(page).to have_field('password')
    expect(page).to have_button('Login')
  end
end