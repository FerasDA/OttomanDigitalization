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

# Ask for call numner file
print "Please enter call number file: "
fileName = gets.chomp

f = File.open(fileName, "r") 
f.each_line do |line|
  puts line
end
f.close