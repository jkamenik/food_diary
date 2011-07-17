Given /^I have (.*) with the following attributes:$/ do |model,table|
  table.hashes.each do |attributes|
    model.singularize.classify.constantize.create! attributes
  end
end

Then /^I should see today's date$/ do
  with_scope('the title') do
    page.should have_xpath('//*', :text => Time.now.to_date.to_s)
  end
end

Then /^I should see a table of food$/ do
  page.should have_css(selector_for "the food table")
end

Then /^show me entries$/ do
  Entry.all.each do |e|
    puts e.inspect
  end
end

Then /^the food table should contain:$/ do |table|
  table.diff! tableish(selector_for("the food table"),'td,th')
end