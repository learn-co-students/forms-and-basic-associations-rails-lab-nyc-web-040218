require 'byebug'
class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
  end

  def new
    @song = Song.new
    @genres = Genre.all
  end

  def create
    @song = Song.new(song_params)

    unless params[:song][:artist].empty?
      @artist = Artist.find_or_create_by(name: params[:song][:artist])
      @song.artist_id = @artist.id
    end

    unless params[:notes][:content][0].empty?
      @note1 = Note.create(content: params[:notes][:content][0])
      @note2 = Note.create(content: params[:notes][:content][1])
      @song.notes = [@note1, @note2]
    end

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = 'Song deleted.'
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :genre_id)
  end
end
