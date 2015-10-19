=begin

Ottoman Digitalization Project 
@author Feras Deiratany

The Ohio State University
Department of Middle East Studies

File: main.rb

=end

require 'mechanize'
require 'nokogiri'
require 'open-uri'


def main
  fileName = "cl_numbers.txt"
  # open file to read from
  f = File.open(fileName, "r")
  
  # open file to write to
  out_file = File.new("out.txt", "w")

  # Initialize new Mechanize agent
  agent = Mechanize.new
  
  # Choosing an agent Firefox
  agent.user_agent_alias = "Linux Firefox"

  # Get OSU Search by LC Library page
  page = agent.get "http://library.ohio-state.edu/search/c"

  # away to handle 429 too many requests error
  lc_record_old = ""
  # oclc number
  oclc = ""
  # get call numbers from file
  f.each_line do |lc_record|
    if lc_record.eql? lc_record_old
      puts 'same oclc'
      out_file.puts oclc
    else 
      # update lc_record_old
      lc_record_old = lc_record
      # Search each record
      search_form = page.form_with :class => "unpadded"
      search_form.field_with(:name => "SEARCH").value = lc_record

      search_results = agent.submit search_form

      # Nokogiri 
      resultPage = Nokogiri::HTML(search_results.body)
      
      # if no matches found 
      if resultPage.css("tr[class='msg']").text.to_s.eql? "No matches found; nearby LC CALL NOS are:"
        puts 'no matches found'
        out_file.puts 'no matches found'
      # if multiple records were found
      elsif resultPage.at_css("table[class='browseList']")
        # puts 'found a list, oclc for first link:'
        # puts 'manual'
        # oclc = 'manual'
        # out_file.puts oclc

        resultPage.search("td[class='browseEntryData']").each do |td|
          if td.at_css("a[name='anchor_1']")
            # puts td.css('a[href]')
            page2 = agent.get td.at('a[href]')[:href]
            # clicked and found one record
            firstRecord = Nokogiri::HTML(page2.body)
            puts 'found one record from list'
            firstRecord.xpath('//a[@href]').each do |link|
              if link['href'].include? "/search~S7?/o"
              oclc = link.text.strip
              end
            end
            out_file.puts oclc
          end
        end
      # if one record is found
      elsif resultPage.css("a[id='recordnum']").text.to_s.eql? "Permanent link to this record"
        puts 'found one record'
        resultPage.xpath('//a[@href]').each do |link|
          if link['href'].include? "/search~S7?/o"
            oclc = link.text.strip
          end
        end
        out_file.puts oclc
      else 
        puts 'manual-diff'
        oclc = 'manual-diff'
        out_file.puts oclc
      end
    end
  end
  f.close
  out_file.close
end

main
