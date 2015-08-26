Then(/^these bill '(.*)' details will be displayed:$/) do |table_name, data|
  step "these '#{table_name}' will be displayed:", data
end