# Entering the challenge:

require_relative 'setup'
require 'nokogiri'
require 'open-uri'

require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

def to_url(code)
  "https://supermariomakerbookmark.nintendo.net/courses/" + code
end

def new_maker(creator_name)
  @db.execute("INSERT INTO makers (name)
    VALUES (?)", [creator_name])
  @db.execute("SELECT LAST_INSERT_ROWID();")[0][0]
end

def new_course(course_title, code, maker_ID)
  @db.execute("INSERT INTO courses (name, code, maker_id)
    VALUES (?, ?, ?)", [course_title, code, maker_ID])
  @db.execute("SELECT LAST_INSERT_ROWID();")[0][0]
end

# User interface

puts "Enter the 19 digit code that is your course ID (e.g. '2D91-0000-02D6-F1E9')."

input = gets.chomp

doc = Nokogiri::HTML(open(to_url(input)))

creator_name = doc.css('.creator-info .name')[0].content
course_title = doc.css('.course-title')[0].content

maker_ID = new_maker(creator_name)

new_course("test course", input, maker_ID)