module CI
  module Metadata
    class Track < Asset
      attributes :ReferenceTitle, :SubTitle, :DisplayArtist, :ParentalWarningType
      attributes :PLineYear, :PLineText, :CLineYear, :CLineText
      attributes :SequenceNumber, :VolumeNumber, :TrackNumber
      attributes :recording, :release
      collections :files, :Genres, :SubGenres, :offers
      #TODO getter and setter for files array, recording, release
      #TODO better way of doing inter-class associations.

      # "GRiD" doesn't auto-camel-case very nicely
      def grid; @parameters['GRiD']; end
      def grid=(grid); @parameters['GRiD'] = grid; end

      def self.path_components(instance=nil)
        if instance && instance.release && instance.sequence_number
          instance.release.path_components + ['track', instance.sequence_number]
        end
      end
    end
  end
end
