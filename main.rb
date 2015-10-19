=begin

Ottoman Digitalization Project 
@author Feras Deiratany

The Ohio State University
Department of Middle East Studies

File: main.rb

=end

require 'mechanize'
require 'nokogiri'


def main
  # Initialize new Mechanize agent
  agent = Mechanize.new
  
  # Choosing an agent Firefox
  agent.user_agent_alias = "Linux Firefox"

  # Get OSU Search by LC Library page
  page = agent.get "http://library.ohio-state.edu/search/c"

  # Search each record
  search_form = page.form_with :class => "unpadded"
  search_form.field_with(:name => "SEARCH").value = "AC141 .S94 1918"

  search_results = agent.submit search_form

  # Nokogiri 
  resultPage = Nokogiri::HTML(search_results.body)
  
  # if no matches found 
  if resultPage.css("tr[class='msg']").text.to_s.eql? "No matches found; nearby LC CALL NOS are:"
    puts 'no matches found'
  # if multiple records were found
  elsif resultPage.at_css("table[class='browseList']")
    puts 'found'
  # if on record is found
  elsif resultPage.css("a[id='recordnum']").text.to_s.eql? "Permanent link to this record"
    puts 'found one record'
  end
end

main
