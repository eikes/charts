[![Code Climate](https://codeclimate.com/github/eikes/graph_tool/badges/gpa.svg)](https://codeclimate.com/github/eikes/graph_tool)

[![Build Status](https://travis-ci.org/eikes/graph_tool.svg?branch=master)](https://travis-ci.org/eikes/graph_tool)

# Graph tool

Generate info graphic elements with ease

# Usage

You can use the command line tool, get help with:

    $ bin/graph_tool --help

Create images:

    $ bin/graph_tool --data 33,22,8 --filename images/dots.jpg

![example dot image](https://raw.githubusercontent.com/eikes/graph_tool/master/images/dots.jpg)

    $ bin/graph_tool --data 18,16 --labels Swimmers,Divers --colors Navy,Teal --style manikin -w 50 -h 50 --filename images/manikin.jpg

![example manikin image](https://raw.githubusercontent.com/eikes/graph_tool/master/images/manikin.jpg)

See https://en.wikipedia.org/wiki/Web_colors#X11_color_names to find more color names you can use.

Create text:

    $ bin/graph_tool --columns 20 --data 55,33,22 --colors x,o,* -t txt

    xxxxxxxxxxxxxxxxxxxx
    xxxxxxxxxxxxxxxxxxxx
    xxxxxxxxxxxxxxxooooo
    oooooooooooooooooooo
    oooooooo************
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
