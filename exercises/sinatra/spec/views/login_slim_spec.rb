require_relative '../spec_helper'

describe 'login.slim' do

  include_context :slim_templates

  subject(:page) { LoginPage.new(render) }
  let(:page_session) { page.browser }

  it 'displays the login fields' do
    expect(page_session).to have_field('username')
    expect(page_session).to have_field('password')
    expect(page_session).to have_button('Login')
  end
end