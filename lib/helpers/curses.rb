module Helper::Curses
  def attrib *attributes
    attributes.each do |attribute|
      Curses.attron  attribute
    end
      yield
    attributes.each do |attribute|
      Curses.attroff  attribute
    end
  end

  def v_center_text text
    Curses.lines / 2
  end

  def h_center_text text
    (Curses.cols / 2) - (text.length / 2)
  end
end

