class TtySlides
  require 'curses'
  require 'io/console'

  require 'tty_slides/version'
  require 'helpers/helper'
  require 'cml/cml'
  require 'main_window'
  require 'q_and_a_window'
  require 'q_and_a_client'
  require 'slide_list'
  require 'options'

  Curses.init_screen
  Curses.noecho
  Curses.curs_set(0) # no cursor please

  def initialize title=''
    @title   = title
    @options = Options.parse!
    @height  = Curses.lines
    @width   = Curses.cols
    @slides  = SlideList.new(@options.start_at)
    setup_windows
    exit_handlers
    setup_q_and_a
  end

  def start
    CML.new(@main_window, File.read(@slides.next)).render

    loop do
      case STDIN.getch
      when /b/i
        CML.new(@main_window, File.read(@slides.previous)).render
      when /q/i
        exit
      else
        CML.new(@main_window, File.read(@slides.next)).render
      end
    end
  end

  private

  def setup_windows
    main_win     = Curses::Window.new(@height - 5, @width, 0, 0)
    @main_window = MainWindow.new(main_win, @title)
    q_and_a_win  = Curses::Window.new(5, @width, @main_window.maxy, 0)
    @q_and_a     = QandAWindow.new(q_and_a_win)
  end

  def setup_q_and_a
    @q_a_client = QandAClient.new(@q_and_a, @options.host, @options.port)
    if !@q_a_client.connected?
      @main_window.resize @height, @width
      Curses.refresh
    end
  end

  def exit_handlers
    at_exit do
      puts "Last Slide: #{@slides.current}" if $!.kind_of?(StandardError)
    end
    at_exit { Curses.close_screen }
  end

end
