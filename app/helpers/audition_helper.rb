module AuditionHelper
  def sortable(column, title=nil)
    title = title.presence || column.titleize
    link_to title, sort: column, direction: direction(column, params[:sort], params[:direction])
  end

  def audition_assigned(column)
    column.map(&:email)
  end

  def direction(column, sort, order)
    if column == sort && order == "asc"
      return "desc"
    else
      return "asc"
    end
  end

  def status_tabs(column, status)
    link_to status, status: status
  end

  def auditions_count(status)
    return Audition.count if status.blank?

    Audition.count_by_status(status)
  end
end
