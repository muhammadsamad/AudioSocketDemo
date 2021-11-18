module AuditionHelper
  def sortable(column, title=nil)
    title ||=column.titleize
    direction = column == params[:sort] && params[:direction] == "asc" ? "desc" : "asc"
    link_to title, :sort => column, :direction => direction
    direction = if column == params[:sort] && params[:direction] == "asc"
                  "desc"
                else
                  "asc"
                end
    link_to title, sort: column, direction: direction
  end

  def statustabs(column, status)
    link_to status, :status => status
    link_to status, status: status
  end

  def assigned_to_map(column)
    column.map { |u| [u.email] }
  end
end
