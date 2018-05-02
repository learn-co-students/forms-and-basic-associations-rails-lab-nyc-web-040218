class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def genre_name=(name)
    self.genre = Genre.find_or_create_by(name: name)
  end

  def genre_name
      self.genre.name
   end

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    self.artist.name
  end

  def note_contents=(content)
   content.each do |e|
     if !e.empty?
       self.notes << Note.create(content: e)
     end
   end
 end

 def note_contents
   self.notes.map {|e| e.content }
 end

end
