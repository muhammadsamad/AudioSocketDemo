module IndexConcern
  extend ActiveSupport::Concern

  def index_finder(query, sort, direction, status)
    if query.present?
      self.search(query)
    elsif sort.present?
      self.order(sort+' '+direction)
    elsif status.present? && status != "All"
      self.where(status: status)
    else
      self.all
    end
  end
end
