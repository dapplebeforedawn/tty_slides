require 'nokogiri'
class CML
  PADDING = 2

  attr_accessor :window
  attr_accessor :text

  def initialize window, text
    @window   = window
    @text     = text
    @document = parse
  end

  def render
    @window.clear
    render_loop @document
    @window.refresh
  end

  private

  def vertically_center(fragment)
    top_line = (@window.maxy - fragment.css('div,line').size) / 2 - PADDING
    @window.setpos(top_line, @window.curx)
  end

  def horizontally_center(text)
    left_pos = (@window.maxx - text.size) / 2
    @window.setpos(@window.cury+1, left_pos)
  end

  def left_align(fragment)
    left_pos = PADDING
    @current_offset ||= 0
    @window.setpos(@window.cury + 1, left_pos + @current_offset)
  end

  def offset_for_code_box(fragment)
    largest_fragment = fragment.css('line').map(&:text).max_by(&:length)
    @current_offset = (@window.maxx - largest_fragment.size) / 2
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
    elsif fragment.node_name == "title"
      title fragment[:style], fragment.text, &recurse
    elsif fragment.node_name == "body"
      body fragment[:style], fragment, &recurse
    elsif fragment.node_name == "code"
      code fragment[:style], fragment, &recurse
    elsif fragment.node_name == "line"
      line fragment[:style], fragment.text, &recurse
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

  def title(attrs, text, &block)
    @window.to_title_position
    attrib *split_attrs(attrs), &block
  end

  def body(attrs, fragment, &block)
    vertically_center(fragment)
    attrib *split_attrs(attrs), &block
  end

  def div(attrs, text, &block)
    @window.setpos(@window.cury + 1, @window.curx)
    horizontally_center(text)
    attrib *split_attrs(attrs), &block
  end

  def span(attrs, &block)
    attrib *split_attrs(attrs), &block
  end

  def line(attrs, fragment, &block)
    left_align(fragment)
    attrib *split_attrs(attrs), &block
  end

  def code(attrs, fragment, &block)
    offset_for_code_box(fragment)
    attrib *split_attrs(attrs), &block
  end

  def split_attrs(attrs_string)
    attrs_string.to_s.split(",")
  end

  def text(text)
    @window << text unless text.match(/^\s+$/) # squash white space like real HTML
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
