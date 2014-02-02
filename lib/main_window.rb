require 'delegate'

class TtySlides::MainWindow < SimpleDelegator
  def initialize window
    super
    refresh
  end

  def to_title_position
    setpos(1, 1)
  end

  def refresh
    box("|", "-")
    setpos(0, 0)
    addstr('[ Ruby Fail ]')
    super
  end
end
