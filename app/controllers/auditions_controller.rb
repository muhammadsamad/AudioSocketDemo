class AuditionsController < ApplicationController
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

private
def audition_params
  params.require(:audition).permit(:firstname, :lastname, :email, :artist_name,
                                   :link, :media, :media_other, :info,
                                   links_attributes: [:id, :link_field, :_destroy], genre: [])
end

end
