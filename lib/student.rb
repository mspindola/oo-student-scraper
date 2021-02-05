require 'pry'

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    @@all << self    
  end

  def self.create_from_collection(students_array)
    students_array.each do |student_hash|
      Student.new(student_hash)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |attr, value|
      self.send("#{attr}=", value)
    end
    self
  end

  def self.all
    @@all
  end
end

# ##Scraper
#   #scrape_index_page
#   is a class method that scrapes the student index page ('./fixtures/student-site/index.html') and a returns an array of hashes in which each hash represents one student
#   #scrape_profile_page
#     is a class method that scrapes a student's profile page and returns a hash of attributes describing an individual student
#     can handle profile pages without all of the social links

# Student
#   #new
#     takes in an argument of a hash and sets that new student's attributes using the key/value pairs of that hash.
#     adds that new student to the Student class' collection of all existing students, stored in the `@@all` class variable.
#   .create_from_collection
#     uses the Scraper class to create new students with the correct name and location.
#   #add_student_attributes
#     uses the Scraper class to get a hash of a given students attributes and uses that hash to set additional attributes for that student.
#   .all
#     returns the class variable @@all

