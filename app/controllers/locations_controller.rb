class LocationsController < ApplicationController
	before_action :set_location, only: [:edit, :show, :update, :destroy]

	def index
		@locations = Location.all
	end

	def import
	  Location.import(params[:file])
	  redirect_to locations_path, notice: 'Locations imported.'
	end

	def show
		# @location = Location.friendly.find(params[:id])
		# @state = @location.state
		# @location_clinics = @location.clinics.all
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
      params.require(:location).permit(:street, :city, :zip, :state, :abrv)
    end
end
