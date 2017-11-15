class ClinicsController < ApplicationController
	before_action :set_clinic, only: [:show, :edit, :update, :destroy]

	def index
		@clinics = Clinic.all
	end

	def import
	  Clinic.import(params[:file])
    redirect_to states_path, notice: 'Locations imported.'
	end

	def show
		@town = @clinic.town
	end

	def new
    @clinic = Clinic.new
    @towns = Town.all
	end

	def create
    @clinic = Clinic.new(clinic_params)
    if @clinic.save
      flash[:success] = "Clinic was successfully created"
      redirect_to town_path(@clinic.town)
    else
      render 'new'
    end
	end

	def edit
	end

	def update
		if @clinic.update(clinic_params)
		  flash[:success] = "Clinic was updated successfully"
      redirect_to clinic_path(@clinic)
		else
		  render 'edit'
		end
	end

	def destroy
		Clinic.find(params[:id]).destroy
  	flash[:success] = "Clinic was successfully deleted!"
    redirect_to states_path
	end

	private
		def set_clinic
			@clinic = Clinic.find(params[:id])
		end

		def clinic_params
      params.require(:clinic).permit(:address, :zipcode, :town_id)
    end
end


# @town.clinic = Clinic.first
# For address inputs: <%= simple_format(@recipe.description)%>
