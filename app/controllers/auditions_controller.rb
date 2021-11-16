class AuditionsController < ApplicationController
  include AuditionsConcern
  before_action :set_audition, only: %i[ show assigned_to_update status_update ]

  def index
    auditions_index
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

  def show
    respond_to do |format|
      format.js
    end
  end

  def my_results
    auditions_index
    respond_to do |format|
      format.html
      format.csv { send_data @auditions.to_csv }
    end
  end

  def assigned_to_update
    @audition[:assigned_to] = params[:assigned_to]
    if @audition.save
      AuditionMailer.with(audition: @audition).assign_audition(@audition).deliver_now
    end
  end

  def status_update
    @audition[:status] = params[:status]
    @audition[:email_description] = params[:email_description]
    if @audition.save
      unless @audition[:status] == "Deleted"
        User.invite!(email: @audition[:email], email_content: @audition[:email_description], update_status: @audition[:status], role: "artist")
      end
    end
  end

  private
  def set_audition
    @audition = Audition.find(params[:id])
  end

  def audition_params
    params.require(:audition).permit(:firstname, :lastname, :email, :artist_name,
                                    :link, :media, :media_other, :info,
                                    links_attributes: [:id, :link_field, :_destroy], genre: [])
  end
end
