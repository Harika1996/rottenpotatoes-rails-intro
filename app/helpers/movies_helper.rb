module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  def sortable(column, title = nil)
    title ||= column.titleize
    link_to title, :sort => column
  end
  def helper_class(field)
    if(params[:sort].to_s == field)
      return 'hilite'
    end
    return nil
  end
end
