require 'delegate'

class MainWindow < SimpleDelegator
  def initialize window
    super
    box("|", "-")
    addstr('[ FAIL ]')
    refresh
  end
end
