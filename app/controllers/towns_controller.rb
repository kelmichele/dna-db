class TownsController < ApplicationController
	# before_action :set_state
	before_action :set_town, only: [:edit, :update, :show]

	def show
		@state = @town.state
	end

	def new
    @town = Town.new
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
		def set_state
			@state = State.find(params[:state_id])
		end

		def set_town
			@town = Town.find(params[:id])
		end

		def town_params
      params.require(:town).permit(:townname)
    end
end
