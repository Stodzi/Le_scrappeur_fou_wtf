# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'

page = Nokogiri::HTML(URI.open('https://coinmarketcap.com/all/views/all/'))

# Je recupère le prix des 20 premières crypto
def retrievePriceCrypto(page)
  inc = 1
  array = []
  20.times do |_n|
    symbol = page.xpath("/html/body/div[1]/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr[#{inc}]/td[5]/div").collect(&:text)
    array << symbol
    inc += 1
  end
  array
end

# Je recupère le nom des 20 premières crypto
def retrieveNameCrypto(page)
  inc = 1
  array = []
  20.times do |_n|
    symbol = page.xpath("/html/body/div[1]/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr[#{inc}]/td[2]/div/a[2]").collect(&:text)
    array << symbol
    inc += 1
  end
  array
end
# Je hash les deux tableaux récupéré
my_hash = {}
retrieveNameCrypto(page).zip(retrievePriceCrypto(page)) { |k, v| my_hash[k] = v }
puts my_hash
