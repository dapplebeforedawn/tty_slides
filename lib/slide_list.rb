class SlideList
  BASE_PATH = Pathname.new(ROOT) + ".." + "slides"

  SLIDES = [
    "introduction",
    "covermymeds",
    "cover-all-mymeds",
    "concurrency-ruby",
    "concurrency-go",
    "concurrency-nodejs",
    "concurrency-summary",
    "events-ruby",
    "events-nodejs",
    "events-summary",
    "bytes-ruby",
    "bytes-nodejs",
    "a-gem",
  ]

  attr_reader :current

  def initialize(start = 0)
    @current = start - 1
  end

  def next
    @current += 1
    @current = SLIDES.size - 1 if @current >= SLIDES.size
    BASE_PATH + "#{SLIDES[@current]}.cml"
  end

  def previous
    @current -= 1
    @current = 0 if @current < 0
    BASE_PATH + "#{SLIDES[@current]}.cml"
  end
end
