class LocationsController < ApplicationController
  before_action :authenticate_user!
  authorize_resource

  def create
    @location = Location.new(location_params)
    if @location.save
      gflash success: "Your location was successfully created."
      redirect_to ironyard_dashboard_users_path
    else
      gflash error: "Something went wrong. Please try again."
      redirect_to ironyard_dashboard_users_path
    end
  end

  def show
    @location = Location.find(params[:id])
    @cohorts = @location.cohorts.order(created_at: :desc)
  end

  private

  def location_params
    params.require(:location).permit(:name, :street_address, :city, :state, :zip_code)
  end

end