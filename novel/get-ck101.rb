#!/usr/bin/env ruby
require 'rubygems'
require 'nokogiri'
require 'open-uri'

raise "Usage: $0 id" unless ARGV[0].to_i > 0 


page = Nokogiri::HTML(open("http://ck101.com/thread-"+ARGV[0]+"-1-1.html"))   

#p page
url_prefix = "http://ck101.com/thread-"+ARGV[0]+"-"
url_postfix = "-1.html"
last_page = page.css("div.pg").first.css("a")[-2]['href'][/thread-\d+-(\d+)-\d+.html/,1]

for i in 1.step(last_page.to_i,1) 
    url = url_prefix+i.to_s+url_postfix
    page = Nokogiri::HTML(open(url))   
#    puts page.xpath('//*[starts-with(@id,"postmessage_")]').each { |article| p article.text[/\n(.*)\r\n/,1] }
    page.xpath('//*[starts-with(@id,"postmessage_")]').each do |article| 
        puts article.text 
        
    end
end
