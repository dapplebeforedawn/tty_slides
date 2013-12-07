require 'patterns-of-failure/version'
require 'helpers/helper'

require 'curses'

Curses.init_screen
Curses.noecho

at_exit { Curses.close_screen }

main_window = Curses::Window.new height - 5, width,                  0, 0
q_and_a     = Curses::Window.new          5, width, main_window.height, 0

main_window.box("|", "-")
q_and_a.box("|", "-")

main_window.addstr('HI IM THE MAIN AREA')
q_and_a.addstr('HI IM THE Q AND A AREA')

main_window.refresh
q_and_a.refresh
