require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url) # is a class method that scrapes the student index page ('./fixtures/student-site/index.html') and a returns an array of hashes in which each hash represents one student
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css("div.roster-cards-container").each do |rostercards| #iterates over the index page
      rostercards.css(".student-card a").each do |student| #iterates inside each student card
        student_profile_link = "#{student.attr('href')}" #work on this?? 
        student_location = student.css('.student-location').text
        student_name = student.css('.student-name').text
        students << {name: student_name, location: student_location, profile_url: student_profile_link}
      end
    end  
    students
    #binding.pry
  end
      
  def self.scrape_profile_page(profile_url)
    student = {}
    profile_page = Nokogiri::HTML(open(profile_url))
    links = profile_page.css(".social-icon-container").children.css("a").map { |i| i.attribute('href').value}
    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link 
      else
        student[:blog] = link
      end
    end
      student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
      student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")
    
    student
  end
end

# Scraper
#   #scrape_index_page
#     is a class method that scrapes the student index page ('./fixtures/student-site/index.html') and a returns an array of hashes in which each hash represents one student
#   #scrape_profile_page
#     is a class method that scrapes a student's profile page and returns a hash of attributes describing an individual student
#     can handle profile pages without all of the social links