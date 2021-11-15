module Auditions
  extend ActiveSupport::Concern

  def auditions_index
    @auditions= if params[:query].present?
                 Audition.search(params[:query])
               elsif params[:sort].present?
                 Audition.order(params[:sort]+' '+params[:direction])
               elsif params[:status].present?
                 Audition.where(status: params[:status])
               else
                 Audition.all
               end
  end
end
