module AuditionHelper
  def sortable(column, title=nil)
    title ||=column.titleize
    direction = if column == params[:sort] && params[:direction] == "asc"
                  "desc"
                else
                  "asc"
                end
    link_to title, sort: column, direction: direction
  end

  def assigned_to_map(column)
    column.map { |u| [u.email] }
  end
end
