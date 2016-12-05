require 'optparse'

class GraphTool::OptParser

  attr_reader :args, :options, :parser

  FORMATS = [:txt, :svg, :png, :jpg, :gif]
  STYLES = [:circle, :cross, :manikin]

  def initialize(args)
    @args = args
    # The options specified on the command line will be collected in *options*.
    # We set default values here.
    @options = {
      type:  :svg,
      style: :circle
    }
    @parser = opt_parser
  end

  # Return a hash describing the options.
  def parse
    parser.parse!(args) # this sets the options
    post_process_options
    validate_options

    options
  end

  def post_process_options
    if options[:filename]
      type = options[:filename].match(/.*\.(#{FORMATS.join("|")})/)
      if type
        options[:type] = type[1].to_sym
      else
        options[:type] = false
      end
    end
  end

  def validate_options
    unless options[:type]
      puts 'No type provided. Set a type with --type flag or by setting a valid --filename'
      fail 'Invalid type'
    end
    unless options[:data]
      puts "No data provided. Please pass in data using the --data flag: 'bin/graph_tool -d Red:8,Gold:7'"
      fail 'Missing data'
    end
  end

  def opt_parser
    OptionParser.new do |opts|
      opts.banner = 'Usage: bin/graph_tool [options]'
      opts.on('-d DATA',
              '--data DATA',
              Array,
              "Provide multiple data points, ie: 'bin/graph_tool -d Red:8,Gold:7'"
             ) do |data|
        options[:data] = data.map { |d| d.split(':') }.to_h
      end
      opts.on('-f FILENAME',
              '--filename FILENAME',
              "Set the filename the result is stored in. Supported formats are: : #{FORMATS.join(', ')}"
             ) do |filename|
        options[:filename] = filename
      end
      opts.on('-s STYLE',
              '--style STYLE',
              STYLES,
              "Choose the graph style: #{STYLES.join(', ')}"
             ) do |style|
        options[:style] = style
      end
      opts.on('-c COLUMNS',
              '--columns COLUMNS',
              Integer,
              'Set number of columns'
             ) do |columns|
        options[:columns] = columns
      end
      opts.on('-w WIDTH',
              '--item-width WIDTH',
              Integer,
              'Sets the width of the individual item'
             ) do |item_width|
        options[:item_width] = item_width
      end
      opts.on('-h HEIGHT',
              '--item-height HEIGHT',
              Integer,
              'Sets the height of the individual item'
             ) do |item_height|
        options[:item_height] = item_height
      end
      opts.on('-t TYPE',
              '--type TYPE',
              FORMATS,
              "If no filename is provided, output is sent to STDOUT, choose the format: #{FORMATS.join(', ')}"
             ) do |type|
        options[:type] = type
      end
      opts.on('--help',
              'Prints this help'
             ) do
        puts opts
        exit
      end
    end
  end

end
