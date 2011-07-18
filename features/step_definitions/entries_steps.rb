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
  # Correct, the table in the feature is the expected value
  tableish(selector_for("food table row"),'td,th').should =~ table.raw
end

Then /^there should be no entries$/ do
  # only 1 header row should exist
  tableish(selector_for("food table row"),'td,th').size.should == 1
end