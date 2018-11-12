# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.clapee.fr"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  add root_path, :priority => 1, :changefreq => 'daily', lastmod: Event.order(created_at: :desc).first.created_at
  #
  # Add all articles:
  #
  Event.find_each do |event|
    add event_path(event), :priority => 0.9, :lastmod => event.updated_at, :changefreq => 'daily'
  end
end
