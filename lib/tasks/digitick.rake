require 'open-uri'
require 'nokogiri'
require 'net/http'

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
        location_latitude: event.xpath('venueLatitude').text,
        location_longitude: event.xpath('venueLongitude').text,
      ).find_or_create_by(location_digitick_id: location_digitick_id)

      event_digitick_id = event.xpath('eventId').text

      event_picture_url = fetch_image(event.xpath('pictureUrl').text)

      Event.create_with(
        title: event.xpath('eventName').text,
        artist_name: event.xpath('artistList/artist/artistNom').text,
        digitick_url: event.xpath('eventUrl').text,
        description: event.xpath('eventPresentation').text,
        status: event.xpath('eventState').text,
        event_picture_url: event_picture_url,
        min_price: event.xpath('minTarif').text,
        digitick_id: event_digitick_id,
        location: location,
        music_genre: event.xpath('subCategoryName').text,
        digitick_date: Time.parse(event.xpath('dateStart').text)
      ).find_or_create_by(digitick_id: event_digitick_id)

      puts "Event #{event_digitick_id} managed!"
    end
    puts "done !"
    exit
  end

  def fetch_image image_source_path
    # TODO: change this URL to image_path('clapee.png')
    return "https://statics.digitick.com/bundles/digitickcms/images/events/defaut.png" if image_source_path.include? "defaut_110.jpg"

    image_path = image_source_path.gsub('evenements/', 'evenements/aff_')

    image_640_path = image_path.gsub('_110', '_640')
    response = Net::HTTP.get_response(URI.parse(image_640_path))
    return image_640_path if response.code != "404"

    image_320_path = image_path.gsub('_110', '_320')
    response = Net::HTTP.get_response(URI.parse(image_320_path))
    return image_320_path if response.code != "404"

    return image_source_path
  end
end



