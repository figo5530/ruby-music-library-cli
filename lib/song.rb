
class Song
    attr_accessor :name
    attr_reader :artist, :genre

    @@all = []
    
    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.songs << self unless genre.songs.include?(self)
    end

    def self.all
        @@all
    end

    def save
        @@all << self
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(name)
        song = self.new(name)
        song.save
        song
    end

    def self.find_by_name(name)
        all.find {|s| s.name == name}
    end

    def self.find_or_create_by_name(name)
        find_by_name(name) || create(name)
    end

    def self.new_from_filename(filename)
        # Action Bronson - Larry Csonka - indie.mp3
        artist_name = filename.gsub(".mp3","").split(" - ")[0]
        song_name = filename.gsub(".mp3","").split(" - ")[1]
        genre_name = filename.gsub(".mp3","").split(" - ")[2]
        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)
        new(song_name,artist,genre)
    end

    def self.create_from_filename(filename)
        song = new_from_filename(filename)
        song.save
    end
end