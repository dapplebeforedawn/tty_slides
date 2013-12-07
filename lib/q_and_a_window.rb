require 'delegate'

class QandAWindow < SimpleDelegator
  def initialize window
    super
    box("|", "-")
    refresh
    addstr('[ Q and A ]')
  end
end

