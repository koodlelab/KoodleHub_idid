module StaticPagesHelper
  def full_title(page_title = '')
    base_page_title = "Koodo Hub"
    if page_title.empty?
      base_page_title
    else
      "#{page_title} | #{base_page_title}"
    end
  end
end