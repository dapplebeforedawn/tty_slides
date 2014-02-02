# TTY Slides

> Gem for presenting slides with the terminal

## Installation

```bash
gem install tty_slides
```

## Usage
Create a startup file (e.g. `start.rb`)
```ruby
#! /usr/bin/env ruby

require "tty_slides"

# define the BASE_PATH and SLIDES
class TtySlides::SlideList
  BASE_PATH = Pathname.new(__FILE__) + ".." + "slides"

  SLIDES = [
    "introduction"
  ]
end

# call `.start`
TtySlides.start
```

Start the presentation:
``bash
bundle exec ruby start.rb
```

## Adding Slides
Slides are stored in bastardized version of HTML that can be rendred with n-curses.  They are found in the `doc/` folder
### CML specification
  - `<head>`: the text node in this element is positioned at the top left of the screen.
  - `<body>`: contains any number of `<div>`, `<span>`, `<code>` or `<line>` tags.
  - `<div>` and `<span>`: go togeather to make a vertially and horizontally centered line.  Each div can be no longer than one line.
  - `<code>` and `<line>`: go togeather to make left aligned text that is in a horizontally and vertically centered box.  Each line, should be one line.  Duh.
  - attributes must be curses attribute calls e.g.
  `Curses.color_pair(RED_COLOR)` becomes `color_pair(RED_COLOR)`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
