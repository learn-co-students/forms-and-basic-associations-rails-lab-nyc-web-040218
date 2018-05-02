class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def genre_name=(name)
    genre = Genre.find_or_create_by(name: name)
    self.genre = genre
  end

  def genre_name
    # self.genre.name
    self.try(:genre).try(:name)
  end

  def artist_name=(name)
    # self.artist = Artist.find_or_create_by(name: name)
    artist = Artist.find_or_create_by(name: name)
   self.artist = artist
  end

  def artist_name
    # self.artist.name
    self.try(:artist).try(:name)
  end

  def note_contents=(contents)
    contents.each do |content|
      if content.size >= 1
        self.notes << Note.create(content: content, song_id: self.id)
      end
    end
  end

  def note_contents
    self.notes.map do |n|
      n.content
    end
  end

end
