module AuditionHelper
  def sortable(column, title=nil)
    title = title.presence || column.titleize
    link_to title, sort: column, direction: direction(column, params[:sort], params[:direction])
  end

  def audition_assigned(column)
    column.map { |u| [u.email] }
  end

  def direction(column, sort, order)
    if column == sort && order == "asc"
      return "desc"
    else
      return "asc"
    end
  end
end
