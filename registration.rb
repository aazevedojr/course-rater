# Entering the challenge:

require_relative 'new_challenge'
require 'nokogiri'
require 'open-uri'
require 'openssl'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

def to_url(code)
  "https://supermariomakerbookmark.nintendo.net/courses/" + code
end

def new_maker(id, name)
  @db.execute("INSERT OR REPLACE INTO makers (id, name)
    VALUES (?, ?)", [id, name])
  id
end

def new_course(id, title, maker_id, challenge_id)
  @db.execute("INSERT OR REPLACE INTO courses (id, title, maker_id, challenge_id)
    VALUES (?, ?, ?, ?)", [id, title, maker_id, challenge_id])
  id
end

def new_rating(rating, feedback, maker_id, course_id)
  @db.execute("INSERT INTO reviews (rating, feedback, maker_id, course_id)
    VALUES (?, ?, ?, ?)", [rating, feedback, maker_id, course_id])
  @db.execute("SELECT LAST_INSERT_ROWID();")[0][0]
end


def add_maker_n_course_to_db(course_id, challenge_id)
  doc = Nokogiri::HTML(open(to_url(course_id)))
  creator_id = /\/profile\/(.*)\?/.match(doc.css('.course-detail-wrapper a#mii')[0].attributes['href'].value)[1]
  creator_name = doc.css('.creator-info .name')[0].content
  course_title = doc.css('.course-title')[0].content
  maker_id = new_maker(creator_id, creator_name)
  new_course(course_id, course_title, maker_id, challenge_id)
end


# User interface

# puts "Enter the 19 digit code that is your course ID (e.g. '2D91-0000-02D6-F1E9')."

# input = gets.chomp
