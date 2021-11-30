class ArtistDetailsController < ApplicationController
  before_action :set_artist, only: %i[ edit update ]

  def new
    @artist_detail = ArtistDetail.new
    @artist_detail.email_address = current_user.email
    @artist_detail.artist_name = Audition.find_by_email(current_user.email).artist_name
  end

  def create
    @artist_detail = ArtistDetail.new(artist_detail_params)
    @artist_detail.user_id = current_user.id
    if @artist_detail.save
      flash[:notice] = "Artist Detail is created successfully"
      redirect_to edit_artist_detail_path(@artist_detail)
    else
      flash[:alert] = "Artist Detail is not created"
      render :new
    end
  end

  def edit
    @artist_detail.email_address = current_user.email
    @artist_detail.user_id = current_user.id
    @artist_detail.artist_name = Audition.find_by_email(current_user.email).artist_name
  end

  def update
    if @artist_detail.update(artist_detail_params)
      flash[:notice] = "Artist Detail is updated successfully"
      redirect_to edit_artist_detail_path(@artist_detail)
    else
     flash[:alert] = "Kindly fill correct details"
     redirect_to edit_artist_detail_path(@artist_detail)
    end
  end

  private
    def set_artist
      @artist_detail = ArtistDetail.find_by_user_id(current_user.id)
    end

    def artist_detail_params
      params.require(:artist_detail).permit(:artist_name, :email_address, :country, :bio, :website_link, :user_id, :profile, social_link: [])
    end
end
