class Public::NotesController < ApplicationController
  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    @note.save
    redirect_to notes_path
  end

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end


  private

  def note_params
    params.require(:note).permit(:title, :body, :image)
  end
end
