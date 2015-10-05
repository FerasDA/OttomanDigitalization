=begin

Ottoman Digitalization Project 
@author Feras Deiratany

The Ohio State University
Department of Middle East Studies

File: get_oclc.rb

=end

require 'rubygems'
# require 'mechanize'
require 'nokogiri'
require 'open-uri'

# Start of main 
base_url = "http://library.ohio-state.edu/search/c?SEARCH="
# Ask for call number file
print "Please enter call number file: "
fileName = gets.chomp

out_file = File.new("out.txt", "w")
oclc = ""
f = File.open(fileName, "r") 
f.each_line do |line|
  line = line.gsub(' ', '+')
  url = "#{base_url}#{line}"
  # using Nokogiri instead of Mechanize 
  # agent = Mechanize.new
  # page = agent.get(url)

  doc = Nokogiri::HTML(open(url))

  if doc.at_css('table.browseList')  
    out_file.puts 'manual' #need to figure out link clicking
  else
    doc.xpath('//a[@href]').each do |link|
      if link['href'].include? "/search~S7?/o"
        oclc = link.text.strip
      end
    end
    out_file.puts oclc
  end

  #   # old mechanize method with regex
  #   #get oclc number (there are two on each page)
  #   x = page.links_with(:href => %r{\/search~S7\?\/o})
  #   out_file.puts x
end
f.close
out_file.close