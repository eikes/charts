require 'optparse'

class GraphTool::OptParser
  attr_reader :args, :options, :parser

  FORMATS = [:txt, :svg, :png, :jpg, :gif].freeze
  STYLES = [:circle, :cross, :manikin].freeze
  DATA_EXAMPLE_ARGS =  '-d 8,7'
  COLOR_EXAMPLE_ARGS =  '--colors red,gold'

  def initialize(args)
    @args = args.empty? ? ['--help'] : args
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
    return if options[:help]
    return unless options[:filename]
    type = options[:filename].match(/.*\.(#{FORMATS.join("|")})/)
    if type
      options[:type] = type[1].to_sym
    else
      options[:type] = false
    end
  end

  def validate_options
    return if options[:help]
    unless options[:type]
      raise 'No type provided. Set a type with --type flag or by setting a valid --filename'
    end
    unless options[:data]
      raise "No data provided. Please pass in data using the --data flag: 'bin/graph_tool #{DATA_EXAMPLE_ARGS}'"
    end
  end

  def opt_parser
    OptionParser.new do |opts|
      opts.banner = 'Usage: bin/graph_tool [options]'
      opts.on(
        '-d DATA',
        '--data DATA',
        Array,
        "Provide multiple data points, ie: 'bin/graph_tool #{DATA_EXAMPLE_ARGS}'"
      ) do |data|
        options[:data] = data
      end
      opts.on(
        '-f FILENAME',
        '--filename FILENAME',
        "Set the filename the result is stored in. Supported formats are: : #{FORMATS.join(', ')}"
      ) do |filename|
        options[:filename] = filename
      end
      opts.on(
        '-s STYLE',
        '--style STYLE',
        STYLES,
        "Choose the graph style: #{STYLES.join(', ')}"
      ) do |style|
        options[:style] = style
      end
      opts.on(
        '--colors COLORS',
        Array,
        "Set the colors to be used, ie: 'bin/graph_tool #{DATA_EXAMPLE_ARGS}' #{COLOR_EXAMPLE_ARGS}' "
      ) do |colors|
        options[:colors] = colors
      end
      opts.on(
        '--columns COLUMNS',
        Integer,
        'Set number of columns'
      ) do |columns|
        options[:columns] = columns
      end
      opts.on(
        '-w WIDTH',
        '--item-width WIDTH',
        Integer,
        'Sets the width of the individual item'
      ) do |item_width|
        options[:item_width] = item_width
      end
      opts.on(
        '-h HEIGHT',
        '--item-height HEIGHT',
        Integer,
        'Sets the height of the individual item'
      ) do |item_height|
        options[:item_height] = item_height
      end
      opts.on(
        '-t TYPE',
        '--type TYPE',
        FORMATS,
        "If no filename is provided, output is sent to STDOUT, choose the format: #{FORMATS.join(', ')}"
      ) do |type|
        options[:type] = type
      end
      opts.on(
        '--help',
        'Prints this help'
      ) do
        puts opts
        options[:help] = true
      end
    end
  end
end
