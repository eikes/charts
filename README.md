[![Code Climate](https://codeclimate.com/github/eikes/graph_tool/badges/gpa.svg)](https://codeclimate.com/github/eikes/graph_tool)

[![Build Status](https://travis-ci.org/eikes/graph_tool.svg?branch=master)](https://travis-ci.org/eikes/graph_tool)

# Graph tool

Generate info graphic elements with ease

# Usage

You can use the command line tool, get help with:

    $ bin/graph_tool --help

Create images:

    bin/graph_tool --data Purple:33,Gold:22,Olive:8 --filename images/dots.jpg

![example dot image](https://raw.githubusercontent.com/eikes/graph_tool/master/images/dots.jpg)

    bin/graph_tool --data Navy:18,Teal:16 --style manikin -w 50 -h 50 --filename images/manikin.jpg

![example manikin image](https://raw.githubusercontent.com/eikes/graph_tool/master/images/manikin.jpg)

See https://en.wikipedia.org/wiki/Web_colors#X11_color_names to find more color names you can use.

Create text:

    $ bin/graph_tool --columns 20 --data X:55,O:33,*:22 -t txt

    XXXXXXXXXXXXXXXXXXXX
    XXXXXXXXXXXXXXXXXXXX
    XXXXXXXXXXXXXXXOOOOO
    OOOOOOOOOOOOOOOOOOOO
    OOOOOOOO************
    **********

# Development

Start by installing bundler:

    gem install bundler

And then install the dependencies:

    bundle install

Run the test suite:

    rake

or

    rspec
