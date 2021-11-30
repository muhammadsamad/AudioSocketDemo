class TracksController < ApplicationController
  before_action :set_album, only: %i[ index new create ]
  before_action :set_track, only: %i[ edit update destroy ]
  before_action :track_album, only: %i[ update destroy ]

  def index
    @tracks = @album.tracks.all
  end

  def new
    @track = @album.tracks.build
    respond_to do |format|
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def create
    @track = @album.tracks.build(track_params)
    if @track.save
      flash[:notice] = "Track is created successfully"
      redirect_to album_tracks_path
    else
      flash[:alert] = "Kindly upload .mp3 or .wav audio file!"
      redirect_to album_tracks_path
    end
  end

  def update
    if @track.update(track_params)
      flash[:notice] = "Track is updated successfully"
      redirect_to album_tracks_path(@album)
    else
      flash[:alert] = "Track is not updated"
      redirect_to album_tracks_path(@album)
    end
  end

  def destroy
    @track.destroy
    flash[:notice] = "Track is deleted"
    redirect_to album_tracks_path(@album)
  end

  private
    def set_album
      @album = Album.find(params[:album_id])
    end

    def set_track
      @track = Track.find(params[:id])
    end

    def track_album
      @album = @track.album
    end

    def track_params
      permitted_params = params.require(:track).permit(:title, :status, :album_status, :artist_detail_id, :album_id, :audio)
      permitted_params[:status] = 'Submitted' if params[:commit] == "Submit"
      permitted_params[:status] = 'Submit' if params[:commit] == "Save to Album"

      permitted_params
    end
end
