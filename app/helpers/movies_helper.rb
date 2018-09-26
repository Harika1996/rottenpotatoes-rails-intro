module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  def sortable(column, title = nil)
    title ||= column.titleize
    id = ""
    if column == "title"
      id = "title_header"
    else
      id = "release_date_header"
    end
    link_to title, {:sort => column}, :id => id
  end
  def helper_class(field)
    if(params[:sort].to_s == field)
      return 'hilite'
    end
    return nil
  end
end
