class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def note_contents
    if self.notes
      self.notes.map{|c| c.content }
    end
  end

  def genre_name=(name)
    self.genre = Genre.find_by name: name
  end

  def genre_name
    self.genre.name
  end

  def artist_name=(name)
    # byebug
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    self.artist.name
  end

  def note_contents=(content)
    content.each do |con|
      if !con.empty?
        self.notes << Note.create(content: con)
      end
    end
  end

  def note_contents
    self.notes.map {|c| c.content }
  end

end