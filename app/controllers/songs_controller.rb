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
    if !params[:song][:artist].empty?
      @song.artist = Artist.find_or_create_by(name: params[:song][:artist])
    end

    if @song.save
      if !params[:notes][:content][0].empty?
        params[:notes][:content].each do |c|
          no = Note.create(content: c, song_id: @song.id)
        end
      end

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
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :genre_id)
  end
end

