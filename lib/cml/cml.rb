require 'nokogiri'
class CML
  attr_accessor :window
  attr_accessor :text

  def initialize window, text
    @window   = window
    @text     = text
    @document = parse
  end

  def render
    render_loop @document
    @window.refresh
  end

  private

  # DFS
  def render_loop(fragment)
    recurse = ->(){
      fragment.children.each do |child|
        render_loop(child)
      end
    }

    if fragment.node_name == "div"
      div fragment[:style], &recurse
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

  def div(attrs, &block)
    @window.insertln
    attrib *attrs.to_s.split(","), &block
  end

  def span(attrs, &block)
    attrib *attrs.to_s.split(","), &block
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

