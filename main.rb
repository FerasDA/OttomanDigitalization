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

  search_form = page.form_with :class => "unpadded"
  search_form.field_with(:name => "SEARCH").value = "BC117.T8 A35 1886"

  search_results = agent.submit search_form
  puts search_results.body
end

main
