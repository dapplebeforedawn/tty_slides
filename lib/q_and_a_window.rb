require 'delegate'

class QandAWindow < SimpleDelegator
  def initialize window
    super
    box("|", "-")
    addstr('[ Q and A ]')
    refresh
  end
end
