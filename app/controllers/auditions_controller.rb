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

  def assigned_to_update
    @audition = Audition.find(params[:audition_id])
    @audition[:assigned_to] = params[:assigned_to]
    if @audition.save
      AuditionMailer.with(audition: @audition).assign_audition(@audition).deliver_now
    end
  end

  private
  def audition_params
    params.require(:audition).permit(:firstname, :lastname, :email, :artist_name,
                                    :link, :media, :media_other, :info,
                                    links_attributes: [:id, :link_field, :_destroy], genre: [])
  end
end
