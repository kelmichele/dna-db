class LocationsController < ApplicationController

	def index
		@locations = Location.all
	end

	def show
	end

	def new
		@location = Location.new
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
	end

	def update
		@location = @location.update(location_params)
		if @location.save
		  flash[:success] = "Location was successfully created"
		  redirect_to location_path(@location)
		else
		  render 'new'
		end
	end

	def destroy
		Location.find(params[:id]).destroy
  	flash[:success] = "Location was successfully deleted!"
    redirect_to locations_path
	end


	private
		def location_params
			params.require(:location).permit(:street, :city, :zip, :statename, :abv)
		end
end
