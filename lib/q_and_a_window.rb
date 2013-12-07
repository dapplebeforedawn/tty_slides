require 'delegate'

class QandAWindow < SimpleDelegator
  def initialize window
    super
    refresh
  end

  def refresh
    box("|", "-")
    addstr('[ Q and A ]')
    super
  end
end
