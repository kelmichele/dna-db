class LocationsController < ApplicationController
	before_action :set_location, only: [:edit, :show, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]

	def index
		@locations = if params[:l]
	    sw_lat, sw_lng, ne_lat, ne_lng = params[:l].split(",")
	    center   = Geocoder::Calculations.geographic_center([[sw_lat, sw_lng], [ne_lat, ne_lng]])
	    distance = Geocoder::Calculations.distance_between(center, [sw_lat, sw_lng])
	    box      = Geocoder::Calculations.bounding_box(center, distance)
	    Location.within_bounding_box(box)
	  elsif params[:near]
	    Location.near(params[:near])
	  else
	    Location.all
		end
	end

	def import
	  Location.import(params[:file])
	  redirect_to locations_path, notice: 'Locations imported.'
	end

	def show
		@town = @location.town
	end

	def new
    @location = Location.new
    @towns = Town.all
	end

	def create
		@location = Location.new(location_params)
		if @location.save
		  flash[:success] = "Location was successfully created"
	    redirect_to locations_path
		else
		  render 'new'
		end
	end

	def edit
	end

	def update
		if @location.update(location_params)
		  flash[:success] = "Location was updated successfully"
	    redirect_to locations_path
		else
		  render 'edit'
		end
	end

	def destroy
		Location.find(params[:id]).destroy
  	flash[:success] = "Location was successfully deleted!"
    redirect_to locations_path
	end

	private
		def set_location
			@location = Location.find(params[:id])
		end

		def require_admin
	    if !current_user.admin?
		    flash[:danger] = "Only admin users can perform that action"
		    redirect_to locations_path
		  end
	  end

		def location_params
      params.require(:location).permit(:street, :town_id, :zip, :latitude, :longitude )
    end
end
