class AuditionsController < ApplicationController
  before_action :set_audition, only: %i[ update ]

  def index
    @auditions = Audition.index_finder(params[:query], params[:sort], params[:direction], params[:status])
  end

  def new
    @audition = Audition.new
    @links = @audition.links.build
  end

  def create
    @audition = Audition.new(audition_params)
    if @audition.save
      redirect_to new_audition_path
    else
      render :new
    end
  end

  def update
    @audition.assigned_to = params[:assigned_to]
    if @audition.save
      AuditionMailer.with(audition: @audition).assign_audition(@audition).deliver_later
    end
  end

  private

  def set_audition
    @audition = Audition.find(params[:audition_id])
  end

  def audition_params
    params.require(:audition).permit(:firstname, :lastname, :email, :artist_name,
                                    :link, :media, :media_other, :info,
                                    links_attributes: [:id, :link_field, :_destroy], genre: [])
  end
end
