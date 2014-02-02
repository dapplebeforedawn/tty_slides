# lazy options parsing:
#   ARGV[0] - the slide you want to start on
#   ARGV[1] - the q and q server hostname
#   ARGV[2] - the q and q server port
require 'curses'
require 'io/console'

ROOT = File.dirname(__FILE__)

require 'tty_slides/version'
require 'helpers/helper'
require 'cml/cml'
require 'main_window'
require 'q_and_a_window'
require 'q_and_a_client'
require 'slide_list'
require 'options'

options = Options.parse!

Curses.init_screen
Curses.noecho
Curses.curs_set(0) # no cursor please

height      = Curses.lines
width       = Curses.cols
main_window = MainWindow.new(Curses::Window.new height - 5, width, 0, 0)
q_and_a     = QandAWindow.new(Curses::Window.new 5, width, main_window.maxy, 0)
slides      = SlideList.new(options.start_at)

q_a_client = QandAClient.new(q_and_a, options.host, options.port)
if !q_a_client.connected?
  main_window.resize height, width
  Curses.refresh
end

CML.new(main_window, File.read(slides.next)).render

at_exit { puts "Last Slide: #{slides.current}" if $!.kind_of?(StandardError) }
at_exit { Curses.close_screen }

loop do
  case STDIN.getch
  when /b/i
    CML.new(main_window, File.read(slides.previous)).render
  when /q/i
    exit
  else
    CML.new(main_window, File.read(slides.next)).render
  end
end
