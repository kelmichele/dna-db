class StatesController < ApplicationController

	def index
		@states = State.all
	end

	def show
		@state = State.find(params[:id])
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

	private
		def state_params
      params.require(:state).permit(:name, :abv)
    end
end


# @town.state = State.first
# For address inputs: <%= simple_format(@recipe.description)%>
