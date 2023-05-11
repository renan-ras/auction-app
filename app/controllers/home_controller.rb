class HomeController < ApplicationController
  def index
    @lots = Lot.all # Lot.approved
  end
end
