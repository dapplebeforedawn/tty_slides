require 'socket'

class TtySlides::QandAClient
  def initialize q_and_a_window, host="localhost", port=3000
    @q_and_a_window = q_and_a_window
    @host           = host || "localhost"
    @port           = port.zero? ? 3000 : port
    @socket         = connect
    @q_and_a_window.scrollok true
    listen if connected?
  end

  def connect
    TCPSocket.new @host, @port
  rescue
    nil
  end

  def connected?
    !@socket.nil?
  end

  private

  def listen
    Thread.new {
      loop do
        @q_and_a_window.setpos 0, 1
        @q_and_a_window << "> "
        @q_and_a_window << @socket.readline
        @q_and_a_window.scrl -1
        @q_and_a_window.refresh
      end
    }
  end
end
