class HomeController < ApplicationController
  def index
    @lots = Lot.approved
  end
end
