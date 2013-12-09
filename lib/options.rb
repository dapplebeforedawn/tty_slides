require 'optparse'
require 'ostruct'
module Options
  def self.parse!
    options = OpenStruct.new host: "localhost", port: 3000,
                         start_at: 0

    OptionParser.new do |opts|
      opts.on("-h", "--host_name=val", String)  { |arg| options.host     = arg }
      opts.on("-p", "--port=val",      Integer) { |arg| options.port     = arg }
      opts.on("-s", "--start_at=",     Integer) { |arg| options.start_at = arg }
      opts.on("", "--help")                     { exec "more #{__FILE__}"      }
    end.parse!
    options
  end
end
