class TownsController < ApplicationController
	before_action :set_town, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]

	def index
		@towns = Town.all
	end

	def import
	  Town.import(params[:file])
	  redirect_to root_url, notice: 'Towns imported.'
	end

	def show
		@town = Town.friendly.find(params[:id])
		@state = @town.state
		@town_clinics = @town.clinics.all
	end

	def new
    @town = Town.new
    @states = State.all
	end

	def create
		@town = Town.new(town_params)
		if @town.save
		  flash[:success] = "Town was successfully created"
		  redirect_to town_path(@town)
		else
		  render 'new'
		end
	end

	def edit
		@state = @town.state
	end

	def update
		if @town.update(town_params)
		  flash[:success] = "Town was updated successfully"
      redirect_to town_path(@town)
		else
		  render 'edit'
		end
	end

	def destroy
		Town.find(params[:id]).destroy
  	flash[:success] = "Town was successfully deleted!"
    redirect_to states_path
	end

	private
		def set_town
			@town = Town.find(params[:id])
		end

		def town_params
      params.require(:town).permit(:townname, :state_id)
    end

    def require_admin
	    if !current_user.admin?
		    flash[:danger] = "Only admin users can perform that action"
		    redirect_back fallback_location: root_path
		  end
	  end
end
