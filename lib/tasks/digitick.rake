namespace :digitick do
  desc "Fetch new events from digitick"
  task fetch: :environment do
    # scrap here
    # for each event from digitick
      # unless event already exist in db
        @event = Event.new()
        @event.save
      # end
    # end
  end
end
