# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create(movie)
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  (page.body.index(e1) < page.body.index(e2)).should be_true
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    if uncheck.nil?
      page.check("ratings_#{rating}")
    else
      page.uncheck("ratings_#{rating}")
    end
  end
end

Then /^I should see all of the movies$/ do
  count  = Movie.count
  page.should have_css("table#movies tbody tr",:count => count.to_i)
end
