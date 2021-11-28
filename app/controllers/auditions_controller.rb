class AuditionsController < ApplicationController
  before_action :set_audition, only: %i[ show update update_status_email ]
  before_action :auditions_index, only: %i[ index auditions_csv ]

  def index; end

  def new
    @audition = Audition.new
    @links = @audition.links.build
  end

  def create
    @audition = Audition.new(audition_params)
    if @audition.save
      redirect_to '/index'
    else
      render :new
    end
  end

  def show
    respond_to do |format|
      format.js
    end
  end

  def auditions_csv
    respond_to do |format|
      format.html
      format.csv { send_data @auditions.to_csv }
    end
  end

  def update
    @audition.assigned_to = params[:assigned_to]
    if @audition.save
      AuditionMailer.with(audition: @audition).assign_audition(@audition).deliver_later
    end
  end

  def update_status_email
    @audition.status = params[:status]
    @audition.email_description = params[:email_description]
    if @audition.save
      unless @audition.status == "Deleted"
        User.invite!(email: @audition.email, email_content: @audition.email_description, update_status: @audition.status, role: User::ARTIST)
      end
    end
  end

  private
  def auditions_index
    @auditions = Audition.index_finder(params[:query], params[:sort], params[:direction], params[:status])
  end

  def set_audition
    @audition = Audition.find(params[:id])
  end

  def audition_params
    params.require(:audition).permit(:firstname, :lastname, :email, :artist_name,
                                    :link, :media, :media_other, :info, :email_description, :status,
                                    links_attributes: [:id, :link_field, :_destroy], genre: [])
  end
end
