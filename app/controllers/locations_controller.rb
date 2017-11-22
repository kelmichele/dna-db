class LocationsController < ApplicationController
	before_action :set_location, only: [:edit, :show, :update, :destroy, :show_state]
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
	end

	def new
    @location = Location.new
    # @states = State.all
	end

	def create
		@location = Location.new(location_params)
		if @location.save
		  flash[:success] = "Location was successfully created"
		  redirect_to location_path(@location)
		else
		  render 'new'
		end
	end

	def edit
		# @state = @location.state
	end

	def update
		if @location.update(location_params)
		  flash[:success] = "Location was updated successfully"
      redirect_to location_path(@location)
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

		def location_params
      params.require(:location).permit(:street, :city, :state, :zip )
    end
end
