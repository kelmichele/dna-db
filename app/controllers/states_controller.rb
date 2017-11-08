class StatesController < ApplicationController
	before_action :set_state, only: [:edit, :update, :show, :destroy]

	def index
		@states = State.all
	end

	def show
	end

	def new
    @state = State.new
	end

	def create
    @state = State.new(state_params)
    if @state.save
      flash[:success] = "State was successfully created"
      redirect_to state_path(@state)
    else
      render 'new'
    end
	end

	def edit
	end

	def update
		if @state.update(state_params)
		  flash[:success] = "State was updated successfully"
      redirect_to state_path(@state)
		else
		  render 'edit'
		end
	end

	def destroy
		State.find(params[:id]).destroy
  	flash[:success] = "State was successfully deleted!"
    redirect_to states_path
	end

	private
		def set_state
			@state = State.find(params[:id])
		end

		def state_params
      params.require(:state).permit(:name, :abv)
    end
end


# @town.state = State.first
# For address inputs: <%= simple_format(@recipe.description)%>
