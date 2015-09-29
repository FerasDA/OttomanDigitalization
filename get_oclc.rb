=begin

Ottoman Digitalization Project 
@author Feras Deiratany

The Ohio State University
Department of Middle East Studies

File: get_oclc.rb

=end

require 'rubygems'
require 'mechanize'

# Start of main 
base_url = "http://library.ohio-state.edu/search/c?SEARCH="
# Ask for call numner file
print "Please enter call number file: "
fileName = gets.chomp

f = File.open(fileName, "r") 
f.each_line do |line|
  # agent = Mechanize.new
  line = line.gsub(' ', '+')
  url = "#{base_url}#{line}"
  puts url
  # page = agent.get(url)
end
f.close