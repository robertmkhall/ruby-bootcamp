require_relative '../support/env'

When(/^I log in with valid credentials$/) do
  browser.login('robertmkhall', 'password')
end

When(/^I log in with invalid credentials$/) do
  browser.login('robertmkhall', 'invalid_password')
end

Given(/^I am not logged in$/) do
  browser.visit(LoginPage, url: application_url('/logout'))
end

Given(/^I am already logged in$/) do
  step "I go to the 'Login' page"
  step 'I log in with valid credentials'
end