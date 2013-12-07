require 'curses'
module Helper::Curses

  Curses.start_color
  ORANGE_COLOR = 20
  RUBINE_COLOR = 10
  Curses.init_color ORANGE_COLOR, 1000, 400, 0
  Curses.init_color RUBINE_COLOR, 800,  0,   250


  BLUE    = 30
  RED     = 70
  CYAN    = 40
  GREEN   = 50
  MAGENTA = 60
  YELLOW  = 80
  WHITE   = 90
  ORANGE  = 20
  RUBINE  = 10

  Curses.init_pair  BLUE,     Curses::COLOR_BLUE,     Curses::COLOR_BLACK
  Curses.init_pair  RED,      Curses::COLOR_RED,      Curses::COLOR_BLACK
  Curses.init_pair  CYAN,     Curses::COLOR_CYAN,     Curses::COLOR_BLACK
  Curses.init_pair  GREEN,    Curses::COLOR_GREEN,    Curses::COLOR_BLACK
  Curses.init_pair  MAGENTA,  Curses::COLOR_MAGENTA,  Curses::COLOR_BLACK
  Curses.init_pair  YELLOW,   Curses::COLOR_YELLOW,   Curses::COLOR_BLACK
  Curses.init_pair  WHITE,    Curses::COLOR_WHITE,    Curses::COLOR_BLACK
  Curses.init_pair  ORANGE,   ORANGE_COLOR,           Curses::COLOR_BLACK
  Curses.init_pair  RUBINE,   RUBINE_COLOR,           Curses::COLOR_BLACK

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
