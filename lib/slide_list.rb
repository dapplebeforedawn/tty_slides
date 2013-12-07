class SlideList
  BASE_PATH = Pathname.new(ROOT) + ".." + "doc"

  SLIDES = [
    "introduction",
  ]

  def initialize
    @current = -1
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
