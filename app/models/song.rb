class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  @notes_array = []

  def genre_name=(name)
    self.genre = Genre.find_or_create_by(name: name)
  end

  def genre_name
    self.try(:genre).try(:name)
  end

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    self.try(:artist).try(:name)
  end

  def note_contents=(contents)
    #       byebug
    # note = Note.find(contents[:id])
    contents.each do |content|
      if content.length >= 1
        note = Note.create(content: content, song_id: self.id)
        self.notes << note
      end
    end
  end

  def note_contents
    self.notes.map do |note|
      note.content
    end
  end

end
