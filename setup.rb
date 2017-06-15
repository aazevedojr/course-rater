# Setting a new Super Mario Maker Challenge up!

require 'sqlite3'

@db = SQLite3::Database.new("course_rater.db")
@db.results_as_hash = true

# Table 'makers':
#   Nintendo Network ID (primary key),
#   Mii's name.

create_makers_table = <<-SQL
  CREATE TABLE IF NOT EXISTS makers(
    id VARCHAR(16) PRIMARY KEY,
    name VARCHAR(10)
  )
SQL

# Table 'courses':
#   In-game Course ID (primary key),
#   Course's title,
#   ID to the maker of the course (foreign key),
#   ID to the challenge that the course was created for.

create_courses_table = <<-SQL
  CREATE TABLE IF NOT EXISTS courses(
    id VARCHAR(19) PRIMARY KEY,
    title VARCHAR(22),
    maker_id INT REFERENCES makers(id),
    challenge_id INT REFERENCES challenges(id)
  )
SQL

# Table 'reviews':
#   An ID (primary key),
#   The course rating (varying from 1 to 5),
#   Feedback to the course creator,
#   ID to the reviewer, who's also a maker (foreign key),
#   ID to the course that's being rated (foreign key).

create_reviews_table = <<-SQL
  CREATE TABLE IF NOT EXISTS reviews(
    id INTEGER PRIMARY KEY,
    rating INT,
    feedback VARCHAR(1200),
    maker_id VARCHAR(16) REFERENCES makers(id),
    course_id VARCHAR(19) REFERENCES courses(id)
  )
SQL

# Table 'challenges':
#   An ID (primary key),
#   Theme,
#   Start date,
#   ID to the maker who chose the theme (foreign key).

create_challenges_table = <<-SQL
  CREATE TABLE IF NOT EXISTS challenges(
    id INTEGER PRIMARY KEY,
    theme VARCHAR(22),
    guidelines VARCHAR(1200),
    start_date DATE,
    maker_id VARCHAR(16) REFERENCES makers(id)
  )
SQL

# Creating the tables:

@db.execute(create_makers_table)
@db.execute(create_courses_table)
@db.execute(create_reviews_table)
@db.execute(create_challenges_table)