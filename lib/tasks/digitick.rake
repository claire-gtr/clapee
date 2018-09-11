require 'open-uri'
require 'nokogiri'

namespace :digitick do
  desc "Fetch new events from digitick"
  task fetch: :environment do

    puts "hello"

    document = Nokogiri::XML(open('http://adxml.publicidees.com/xml.php?progid=1472&partid=56740&n=Digitick_flux_concerts'))

    document.xpath('//eventList/event').each do |event|
      event_id = event.xpath('eventId').text
      name = event.xpath('eventName').text
      artist = event.xpath('artistList/artist/artistNom').text
      url = event.xpath('eventUrl').text
      description = event.xpath('eventPresentation').text
      status = event.xpath('eventState').text
      place_id = event.xpath('venueId').text
      place_name = event.xpath('venueName').text
      town = event.xpath('venueTown').text
      address = event.xpath('venueAdress').text
      zipcode = event.xpath('venueZipcode').text
      picture_url = event.xpath('venueUrl').text


      if event_id == "606375"
        puts name
        puts artist
        puts url
        puts description
        puts place_name
        puts town
      end

    end

puts "finished"

    # scrap here
    # for each event from digitick
      # unless event already exist in db
        @event = Event.new()
        @event.save
      # end
    # end
  end
end
