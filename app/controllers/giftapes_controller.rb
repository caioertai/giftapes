class GiftapesController < ApplicationController
  def index
    @giftapes = Giftape.where(user: current_user)
  end

  def show
    @giftape = Giftape.find_by(custom_url: params[:custom_url])
    @curated_list_item = CuratedListItem.new

    if @giftape.giftable_type == 'Mixtape'
      @tracks_array = []

      @giftape.giftable.tracks.each do |track|
        # create key called t: and append t.url, t.url
        @tracks_hash = { url: track.youtube_url, start: track.start_time, end: track.end_time }
        @tracks_array << @tracks_hash
      end
      @tracks_json = JSON.generate(@tracks_array)
    end
  end
end
