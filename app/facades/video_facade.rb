class VideoFacade

  def self.country_video(country)
    videos = YoutubeService.videos_of_country(country)[:items].map do |video|
      Video.new(video)
    end
    videos[0]
  end
end
