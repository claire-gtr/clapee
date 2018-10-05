module ApplicationHelper
  include Pagy::Frontend

  def capitalize_apostrophe(str)
    # location.name.split(/ |\_/).map(&:capitalize).join(" ")
    str.capitalize.gsub(/[' ][a-z]/, &:upcase)
  end
end

