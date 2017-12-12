class NotesController < ApplicationController
  def create
    @chatroom = Chatroom.includes(:recipient).find(params[:chatroom_id])
    @note = @chatroom.notes.create(note_params)

    respond_to do |format|
      format.js
    end
  end

  private

  def note_params
    params.require(:note).permit(:user_id, :body)
  end
end
