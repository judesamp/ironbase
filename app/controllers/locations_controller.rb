class LocationsController < ApplicationController

  def create
    @location = Location.new(location_params)
    if @location.save
      redirect_to ironyard_dashboard_users_path, notice: "Your location was successfully created."
    else
      redirect_to ironyard_dashboard_users_path, notice: "Something went wrong. Please try again."
    end
  end

  def show
    @location = Location.find(params[:id])
  end

  private

  def location_params
    params.require(:location).permit(:name, :street_address, :city, :state, :zip_code)
  end

end