require 'delegate'

class QandAWindow < SimpleDelegator
  def initialize window
    super
    refresh
  end

  def refresh
    box("|", "-")
    setpos(0, 0)
    addstr('[ Q and A ]')
    super
  end
end
