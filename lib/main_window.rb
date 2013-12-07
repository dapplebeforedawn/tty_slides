require 'delegate'

class MainWindow < SimpleDelegator
  def initialize window
    super
    box("|", "-")
    refresh
    addstr('[ FAIL ]')
  end
end

