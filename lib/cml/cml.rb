require 'nokogiri'
class CML
  BORDER_COST = 2

  attr_accessor :window
  attr_accessor :text

  def initialize window, text
    @window   = window
    @text     = text
    @document = parse
  end

  def render
    vertically_center
    render_loop @document
    @window.refresh
  end

  private

  def vertically_center
    top_line = (@window.maxy - @document.css('div').size) / 2 - BORDER_COST
    @window.setpos(top_line, @window.curx)
  end

  def horizontally_center(text)
    left_pos = (@window.maxx - text.size) / 2
    @window.setpos(@window.cury, left_pos)
  end

  # DFS
  def render_loop(fragment)
    recurse = ->(){
      fragment.children.each do |child|
        render_loop(child)
      end
    }

    if fragment.node_name == "div"
      div fragment[:style], fragment.text, &recurse
    elsif fragment.node_name == "span"
      span fragment[:style], &recurse
    elsif fragment.node_name == "text"
      text fragment.text, &recurse
    else
      recurse.call
    end
  end

  def parse
    Nokogiri::HTML.parse(@text)
  end

  def div(attrs, text, &block)
    @window.setpos(@window.cury + 1, @window.curx)
    horizontally_center(text)
    attrib *split_attrs(attrs), &block
  end

  def span(attrs, &block)
    attrib *split_attrs(attrs), &block
  end

  def split_attrs(attrs_string)
    attrs_string.to_s.split(",")
  end

  def text(text)
    @window << text
    yield
  end

  def attrib *attributes
    attributes.each do |attribute|
      @window.attron  Curses.instance_eval(attribute)
    end
      yield
    attributes.each do |attribute|
      @window.attroff  Curses.instance_eval(attribute)
    end
  end

end
