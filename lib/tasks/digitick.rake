require 'open-uri'
require 'nokogiri'
require 'net/http'
require 'zipruby'


namespace :digitick do
  desc "Fetch new events from digitick"
  task fetch: :environment do

    puts "Fetching event from Digitick..."
    url = 'https://productdata.awin.com/datafeed/download/apikey/20721b5adb99ac0924a6cf7fb8c4ee92/language/fr/cid/590/columns/aw_deep_link,product_name,aw_product_id,merchant_product_id,merchant_image_url,description,merchant_category,search_price,merchant_name,merchant_id,category_name,category_id,aw_image_url,currency,store_price,delivery_cost,merchant_deep_link,language,last_updated,Travel%3Alocation,is_for_sale,Tickets%3Aprimary_artist,Tickets%3Asecond_artist,Tickets%3Aevent_date,Tickets%3Aevent_name,Tickets%3Avenue_name,Tickets%3Avenue_address,Tickets%3Aavailable_from,Tickets%3Agenre,Tickets%3Amin_price,Tickets%3Amax_price,Tickets%3Alatitude,Tickets%3Alongitude,Tickets%3Aevent_location_address,Tickets%3Aevent_location_zipcode,Tickets%3Aevent_location_city,Tickets%3Aevent_location_region,Tickets%3Aevent_location_country,Tickets%3Aevent_location_coordinates,Tickets%3Aevent_duration,display_price,data_feed_id/format/csv/delimiter/%2C/compression/zip/'
    zipfile = open('/tmp/zipfile.zip', 'w')
    zipfile << open(url).read.force_encoding('utf-8')

    unzipped_document = Zip::Archive.open("/tmp/zipfile.zip") do |archive|
      zipfile_path = archive.get_name(0)
      archive.fopen(zipfile_path) do |f|
        document_string = CGI.unescapeHTML(f.read.force_encoding('utf-8'))
        csv_options = { headers: :first_row, header_converters: :symbol }
        locations_not_found = []
        CSV.parse(document_string, csv_options) do |row|
          location_name = row[:ticketsvenue_name]
          location = Location.where("name ILIKE ?", "%#{location_name}%").first

          unless location
            location = Location.create(
              name: location_name,
              address: row[:ticketsvenue_address],
              location_latitude: row[:ticketslatitude].to_f,
              location_longitude: row[:ticketslongitude].to_f
            )
            puts "New location created: #{location_name}"
          end

          event_digitick_id = row[:aw_product_id]
          event_picture_url = fetch_image(row[:merchant_image_url])
          Event.create_with(
            title: row[:product_name],
            digitick_url: row[:aw_deep_link],
            description: row[:description],
            status: row[:is_for_sale],
            min_price: row[:ticketsmin_price],
            digitick_id: event_digitick_id,
            location: location,
            digitick_date: Time.parse(row[:ticketsevent_date]),
            event_picture_url: row[:merchant_image_url],
          ).find_or_create_by(digitick_id: event_digitick_id)
        end

      end
    end
  end

  def fetch_image image_source_path
    return "/assets/default-clapee.jpg" if image_source_path.include? "defaut_110.jpg"
    image_path = image_source_path.gsub('evenements/', 'evenements/aff_')

    begin
      image_640_path = image_path.gsub(/_[0-9]+/, '_640')
      response = RestClient::Request.execute(
        url: URI.parse(image_640_path).to_s,
        method: :get,
        verify_ssl: false
      )
      return image_640_path if response.code != "404"
    rescue
      begin
        image_320_path = image_path.gsub(/_[0-9]+/, '_320')
        response = RestClient::Request.execute(
          url: URI.parse(image_320_path).to_s,
          method: :get,
          verify_ssl: false
        )
        return image_320_path if response.code != "404"
      rescue
        return image_source_path
      end
    end
  end
end
