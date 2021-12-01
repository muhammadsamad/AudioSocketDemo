class AuditionsController < ApplicationController
  before_action :set_audition, only: :update
  before_action :find_auditions, only: %i[ index format_csv ]

  def index;  end

  def new
    @audition = Audition.new
    @links = @audition.links.build
  end

  def create
    @audition = Audition.new(audition_params)
    if @audition.save
      flash[:notice] = "Audition is submitted successfully"
      redirect_to new_audition_path
    else
      flash[:alert] = "Kindly fill your audition form with correct information"
      render :new
    end
  end

  def update
    AuditionMailer.assign_audition(@audition).deliver_later if @audition.update(assigned_to: params[:assigned_to])
  end

  def format_csv
    send_data @auditions.to_csv
  end

  private
  def set_audition
    @audition = Audition.find(params[:id])
  end

  def find_auditions
    @auditions = Audition.search(params[:query], params[:sort], params[:direction], params[:status])
  end

  def audition_params
    params.require(:audition).permit(:firstname, :lastname, :email, :artist_name,
                                    :link, :media, :media_other, :info, :assigned_to,
                                    links_attributes: [:id, :link_field, :_destroy], genre: [])
  end
end
