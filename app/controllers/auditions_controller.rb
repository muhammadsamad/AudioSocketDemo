class AuditionsController < ApplicationController
  include Auditions

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
    @audition = Audition.find(params[:id])
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
    @audition = Audition.find(params[:audition_id])
    @audition[:assigned_to] = params[:assigned_to]
    if @audition.save
      AuditionMailer.with(audition: @audition).assign_audition(@audition).deliver_now
    end
  end

  def status_update
    @audition = Audition.find(params[:audition_id])
    @audition[:status] = params[:status]
    @audition[:email_description] = params[:email_description]
    if @audition.save
      AuditionMailer.with(audition: @audition).audition_status_email(@audition).deliver_now
    end
  end

  private
  def audition_params
    params.require(:audition).permit(:firstname, :lastname, :email, :artist_name,
                                    :link, :media, :media_other, :info,
                                    links_attributes: [:id, :link_field, :_destroy], genre: [])
  end
end
