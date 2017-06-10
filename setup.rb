# Setting a new Super Mario Maker Challenge up!

require 'sqlite3'

db = SQLite3::Database.new("challenge.db")
db.results_as_hash = true

create_makers_table = <<-SQL
  CREATE TABLE IF NOT EXISTS makers(
    id INTEGER PRIMARY KEY,
    name VARCHAR(10)
  )
SQL

create_courses_table = <<-SQL
  CREATE TABLE IF NOT EXISTS courses(
    id INTEGER PRIMARY KEY,
    name VARCHAR(22),
    code VARCHAR(19),
    maker_id INT REFERENCES makers(id)
  )
SQL

create_reviews_table = <<-SQL
  CREATE TABLE IF NOT EXISTS reviews(
    id INTEGER PRIMARY KEY,
    stars VARCHAR(19),
    feedback VARCHAR(300),
    maker_id INT REFERENCES makers(id),
    course_id INT REFERENCES courses(id)
  )
SQL

db.execute(create_makers_table)
db.execute(create_courses_table)
db.execute(create_reviews_table)