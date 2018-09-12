require 'open-uri'
require 'nokogiri'

namespace :digitick do
  desc "Fetch new events from digitick"
  task fetch: :environment do

    puts "hello"

    document = Nokogiri::XML(open('http://adxml.publicidees.com/xml.php?progid=1472&partid=56740&n=Digitick_flux_concerts'))

    document.xpath('//eventList/event').each do |event|
      location_digitick_id = event.xpath('venueId').text

      location = Location.create_with(
        name: event.xpath('venueName').text,
        town: event.xpath('venueTown').text,
        address: event.xpath('venueAdress').text,
        zipcode: event.xpath('venueZipcode').text,
      ).find_or_create_by(location_digitick_id: location_digitick_id)

      event_digitick_id = event.xpath('eventId').text

      Event.create_with(
        title: event.xpath('eventName').text,
        artist_name: event.xpath('artistList/artist/artistNom').text,
        digitick_url: event.xpath('eventUrl').text,
        description: event.xpath('eventPresentation').text,
        status: event.xpath('eventState').text,
        event_picture_url: event.xpath('venueUrl').text,
        digitick_id: event_digitick_id,
        location: location
      ).find_or_create_by(digitick_id: event_digitick_id)

      puts "Event #{event_digitick_id} managed!"
    end
    puts "done !"
    exit
  end
end



