class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :legalpage]

  def home
  end

  def legalpage
  end
end
