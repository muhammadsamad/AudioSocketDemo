class AlbumsController < ApplicationController
  before_action :set_artist, only: %i[ new create index edit update destroy ]
  before_action :set_album, only: %i[ edit update destroy ]

  def index
    @albums = @artist_detail.albums
  end

  def new
    @album = @artist_detail.albums.build
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
    @album = @artist_detail.albums.build(album_params)
    if @album.save
      flash[:notice] = "Album is created successfully"
      redirect_to artist_detail_albums_path
    else
      flash[:alert] = "Album is not created"
      render :new
    end
  end

  def update
    if @album.update(album_params)
      flash[:notice] = "Album is updated successfully"
      redirect_to artist_detail_albums_path(@artist_detail)
    else
      flash[:alert] = "Album is not updated"
      render :edit
    end
  end

  def destroy
    @album.destroy
    flash[:alert] = "Album is deleted successfully"
    redirect_to artist_detail_albums_path(@artist_detail)
  end

  private
  def set_artist
    @artist_detail = ArtistDetail.find_by_user_id(current_user.id)
  end

  def set_album
    @album = Album.find(params[:id])
  end

  def album_params
    params.require(:album).permit(:id, :name, :artwork, :album_status, :artist_detail_id)
  end
end
