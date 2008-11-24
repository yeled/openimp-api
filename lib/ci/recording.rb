module CI
  class Recording < Asset
    primary_key   :ISRC
    base_url      :"recording/isrc"
    attributes    :Duration, :LabelName, :MainArtist
    collections   :Producers, :Mixers, :Composers, :Lyricists, :FeaturedArtists, :Artists, :tracks, :files

    def initialize parameters = {}
      super
      @files = []
      @tracks = []
    end

    def newest_track
      get url('newest')
    end
  end

  #TODO add methods to get encodings etc.
end