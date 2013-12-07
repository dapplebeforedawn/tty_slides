require 'patterns-of-failure/version'
require 'helpers/helper'
require 'cml/cml'
require 'main_window'
require 'q_and_a_window'

require 'curses'
require 'io/console'

require 'pry'

Curses.init_screen
Curses.noecho
Curses.curs_set(0) # no cursor please

at_exit { Curses.close_screen }

height      = Curses.lines
width       = Curses.cols
main_window = MainWindow.new(Curses::Window.new height - 5, width, 0, 0)
q_and_a     = QandAWindow.new(Curses::Window.new 5, width, main_window.maxy, 0)

path = File.join File.dirname(__FILE__), "..", "doc", "introduction.cml"
cml = CML.new main_window, File.read(path)
cml.render
STDIN.getch
