# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'

def deputy_url
  url = Nokogiri::HTML(URI.open('http://www2.assemblee-nationale.fr/deputes/liste/alphabetique'))
  deputy_url = url.xpath('//*[@id="deputes-list"]//a/@href').collect(&:text)
  # puts deputy_url
  url = []
  deputy_url.map do |u|
    each_deputy_url = "http://www2.assemblee-nationale.fr#{u}"
    url << each_deputy_url
  end
  # puts url
  url
end

def deputy_informations
  array = []
  deputy_url.each do |x|
    doc =  Nokogiri::HTML(URI.open(x))
    deputy_email = doc.xpath('//*[@id="haut-contenu-page"]/article/div[3]/div/dl/dd[4]/ul/li[2]/a').text
    deputy_full_name = doc.xpath(' //*[@id="haut-contenu-page"]/article/div[2]/h1').text
    deputy_full_name1 = deputy_full_name.gsub('Mme ', '').gsub('M. ', '').split(' ')
    deputy_last_name = deputy_full_name1.delete(deputy_full_name1.last)
    deputy_first_name = deputy_full_name1.delete(deputy_full_name1.first)

    deputy_hash = { 'first_name' => deputy_first_name, 'last_name' => deputy_last_name, 'email' => deputy_email }
    array << deputy_hash
  end
  puts array
end
deputy_url
deputy_informations
