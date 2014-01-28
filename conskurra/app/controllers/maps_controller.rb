class MapsController < ApplicationController
  # GET /maps
  # GET /maps.json
  def index
    @maps = current_user.find_locations if current_user
  end
end
