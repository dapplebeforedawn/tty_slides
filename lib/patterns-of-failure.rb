require 'patterns-of-failure/version'
require 'helpers/helper'
require 'cml/cml'

require 'curses'
require 'io/console'

require 'pry'

Curses.init_screen
Curses.noecho
Curses.curs_set(0) # no cursor please

at_exit { Curses.close_screen }

height      = Curses.lines
width       = Curses.cols
main_window = Curses::Window.new height - 5, width,                0, 0
q_and_a     = Curses::Window.new          5, width, main_window.maxy, 0

main_window.box("|", "-")
q_and_a.box("|", "-")

main_window.addstr('[ FAIL ]')
q_and_a.addstr('[ Q and A ]')

main_window.refresh
q_and_a.refresh

path = File.join File.dirname(__FILE__), "..", "doc", "introduction.cml"
cml = CML.new main_window, File.read(path)
cml.render
STDIN.getch
