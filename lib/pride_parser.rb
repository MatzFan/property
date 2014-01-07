require 'appscript'

class PrideParser

  skim = Appscript.app('Skim.app')
  skim.open('/Users/me/Desktop/scan2read.pdf')

  doc = skim.documents[1].get
  pages = doc.pages.get
  num_pages = pages.count
  page_line_bounds = doc.pages.line_bounds.get # line bounds for every page
  num_pages = page_line_bounds.count
  page_char_bounds = Array.new(num_pages, [])
  pages.each do |page|
    chars = doc.page.text.characters.get
    for i in 1..chars.count
      page_char_bounds[i - 1] << pages[0].text.characters[i].get_bounds_for
    end
  end

end # of class
