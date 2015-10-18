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
  search_form.field_with(:name => "SEARCH").value = "AC141 .K54 1911"

  search_results = agent.submit search_form

  # Nokogiri 
  resultPage = Nokogiri::HTML(search_results.body)

  # get error class
  error = resultPage.css("tr[class='msg']")
  
  # if no matches found 
  if error.text.to_s.eql? "No matches found; nearby LC CALL NOS are:"
    puts 'no matches found'
  else 
    puts 'found'
  end

end

main
