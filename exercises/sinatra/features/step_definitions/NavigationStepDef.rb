require_relative '../support/env'
require 'capybara/cucumber'

Given(/^I go to the '(.*)' page$/) do |page|
  browser.visit(page_class(page), url: page_url(page))
end

Then(/^I will be on the '(.*)' page$/) do |page|
  page_class = page_class page
  current_page_class = browser.current_page.class

  fail "Still on the #{current_page_class}" unless current_page_class == page_class
end

Then(/^I will be redirected to the '(.*)' page$/) do |page|
  step "I will be on the '#{page}' page"
end