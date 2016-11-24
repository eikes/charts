[![Code Climate](https://codeclimate.com/github/eikes/graph_tool/badges/gpa.svg)](https://codeclimate.com/github/eikes/graph_tool)

[![Build Status](https://travis-ci.org/eikes/graph_tool.svg?branch=master)](https://travis-ci.org/eikes/graph_tool)

# Graph tool

Generate info graphic elements with ease

# Usage

You can use the command line tool:

    $ bin/graph_tool -c 20 -d X:55,O:33,*:22 -t txt

    XXXXXXXXXXXXXXXXXXXX
    XXXXXXXXXXXXXXXXXXXX
    XXXXXXXXXXXXXXXOOOOO
    OOOOOOOOOOOOOOOOOOOO
    OOOOOOOO************
    **********

    bin/graph_tool -d Purple:33,Gold:22,Olive:8 -f images/dots.jpg

    ![example image](https://raw.githubusercontent.com/eikes/graph_tool/master/images/dots.jpg)

# Development

Start by installing bundler:

    gem install bundler

And then install the dependencies:

    bundle install

Run the test suite:

    rake

or

    rspec
