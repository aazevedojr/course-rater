# BUSINESS LOGIC

# Instance Methods of 'Challenge'
# For now, it will interact directly with the database.

require_relative 'registration'

enjoyed = []

# USER INTERFACE

courses = @db.execute("SELECT * FROM courses")
courses.each do |course|
puts "Did you enjoy playing #{course['name']}? Y/N"
enjoyed << gets.chomp
end

enjoyed.each do |rate|
  @db.execute("INSERT INTO reviews (stars) VALUES (?)",
  [if (rate == 'Y' || rate == 'y') then 1 else 0 end])
end