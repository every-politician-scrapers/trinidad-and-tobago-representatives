#!/bin/env ruby
# frozen_string_literal: true

require 'cgi'
require 'every_politician_scraper/scraper_data'
require 'open-uri/cached'

class Legislature
  # details for an individual member
  class Member < Scraped::HTML
    field :id do
      CGI.parse(url)['id'].first
    end

    # Reverse the order
    field :name do
      display_name.split(', ', 2).reverse.join(' ')
    end

    field :party do
      tds[2].text.tidy
    end

    field :constituency do
      tds[3].text.tidy
    end

    private

    def display_name
      tds[1].css('a').text
    end

    def url
      tds[1].css('a/@href').text
    end

    def tds
      noko.css('td')
    end
  end

  # The page listing all the members
  class Members < Scraped::HTML
    field :members do
      members_list.xpath('.//tr[td[2]]').map { |mp| fragment(mp => Member).to_h }
    end

    private

    def members_list
      noko.css('.listTable')
    end
  end
end

url = 'http://www.ttparliament.org/members.php?mid=54'
puts EveryPoliticianScraper::ScraperData.new(url).csv
