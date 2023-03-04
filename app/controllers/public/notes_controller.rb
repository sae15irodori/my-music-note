class Public::NotesController < ApplicationController
  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    if @note.save!
      flash[:notice] = "Create Note!"
      redirect_to notes_path
    else
      render :new
    end
  end

  def index
    @notes = Note.all
  end

  def show
    @note = Note.find(params[:id])
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    if @note.update(note_params)
      flash[:notice] = "Update!"
      redirect_to note_path(@note.id)
    else
      render :edit
    end
  end

  def destroy
    @note = Note.find(params[:id])
    if @note.destroy
      flash[:notice] = "ノートを消しました"
      redirect_to notes_path
    else
      render :edit
    end
  end


  private

  def note_params
    params.require(:note).permit(:title, :body, :image)
  end
end
