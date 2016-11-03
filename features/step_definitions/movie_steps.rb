# Add a declarative step here for populating the DB with movies.
total_Movies = 0
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
    total_Movies = total_Movies + 1
  end
  flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  matched = /#{e1}.*#{e2}/m =~ page.body
  assert !matched.nil?
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(',').each { |r|
    ratig = 'ratings[' + r.strip + ']'
    if is_unchecked.nil?
      uncheck(ratig)
    else
      check(ratig)
    end
  }
end

Then /I should see all the movies/ do
  page.should have_css("table#movies tbody tr", :count => movies_count.to_i)
end
