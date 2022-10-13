# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'

# Recherche des noms des Mairies dans le tableau page
def get_townhall_name(townhall_url)
  name_commune = Nokogiri::HTML(URI.open(townhall_url))

  name = name_commune.xpath('//div/main/section[1]/div/div/div/h1').text
  name[0..-9]
end

# Recherche des urls des Mairies dans le tableau page
def get_townhall_urls
  specific_url = Nokogiri::HTML(URI.open('http://annuaire-des-mairies.com/val-d-oise.html')).xpath('//a[@class="lientxt"]/@href')

  specific_url.map { |x| "https://www.annuaire-des-mairies.com#{x.text[1..]}" }
end

# Recherche des mails des Mairies
def get_townhall_email(townhall_url)
  commune = Nokogiri::HTML(URI.open(townhall_url))
  commune.xpath('//div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
end

# Création du hash
Hash.class_eval do
  def split_into(divisions)
    count = 0
    each_with_object([]) do |key_value, final|
      final[count % divisions] ||= {}
      final[count % divisions].merge!({ key_value[0] => key_value[1] })
      count += 1
    end
  end
end

def perform
  mail = []
  name = []

  get_townhall_urls.each do |x|
    mail << get_townhall_email(x)
    name << get_townhall_name(x)
  end
  # Hash Final
  hash_all = Hash[name.zip(mail)]

  # puts hash_all
  # Mise en forme du tableau
  new_array = hash_all.split_into(name.size)

  puts new_array
  puts new_array.count
end

perform
