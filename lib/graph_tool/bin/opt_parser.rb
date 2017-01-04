require 'optparse'

class GraphTool::OptParser
  attr_reader :args, :options, :parser

  FORMATS = [:txt, :svg, :png, :jpg, :gif].freeze
  STYLES = [:circle, :cross, :manikin, :bar, :pie].freeze
  DATA_EXAMPLE_ARGS = '-d 8,7'.freeze
  COLOR_EXAMPLE_ARGS = '--colors red,gold'.freeze
  FLOAT_INTEGER_REGEX = /^(?=.)([+-]?([0-9]*)(\.([0-9]+))?)$/.freeze

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
    infer_type_from_filename
    validate_options

    options
  end

  def post_process_options
    # force 2-dimensional array for bar graph if only one data set is provided
    if options[:style] == :bar and !options[:data].first.is_a? Array
      options[:data] = [options[:data]]
    end
  end

  def infer_type_from_filename
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
        data = data.map { |d| d.match(FLOAT_INTEGER_REGEX) ? Float(d) : nil }
        # if multiple --data arguments are provided,
        # the data option becomes a two dimensional array
        if !options[:data]
          options[:data] = data
        else
          options[:data] = [options[:data]] unless options[:data].first.is_a? Array
          options[:data].push(data)
        end
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
        "Choose the graph style: #{STYLES.join(', ')} (circle, cross and manikin are count graphs)"
      ) do |style|
        options[:style] = style
      end
      opts.on(
        '-t TITLE',
        '--title TITLE',
        "Set the title"
      ) do |title|
        options[:title] = title
      end
      opts.on(
        '--labels LABELS',
        Array,
        "Set the labels to be used, ie: 'bin/graph_tool #{DATA_EXAMPLE_ARGS} --labels Failures,Successes' "
      ) do |labels|
        options[:labels] = labels
      end
      opts.on(
        '--group-labels GROUP_LABELS',
        Array,
        "Set the group-labels to be used, ie: 'bin/graph_tool #{DATA_EXAMPLE_ARGS} --style bar --group-labels Summer,Winter' "
      ) do |group_labels|
        options[:group_labels] = group_labels
      end
      opts.on(
        '--colors COLORS',
        Array,
        "Set the colors to be used, ie: 'bin/graph_tool #{DATA_EXAMPLE_ARGS} #{COLOR_EXAMPLE_ARGS}' "
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
        '--width WIDTH (not for count graphs)',
        Integer,
        'Sets the image width'
      ) do |width|
        options[:width] = width
      end
      opts.on(
        '-h HEIGHT',
        '--height HEIGHT (not for count graphs)',
        Integer,
        'Sets the image height'
      ) do |height|
        options[:height] = height
      end
      opts.on(
        '--item-width WIDTH',
        Integer,
        'Sets the width of the individual item (count graphs only)'
      ) do |item_width|
        options[:item_width] = item_width
      end
      opts.on(
        '--item-height HEIGHT',
        Integer,
        'Sets the height of the individual item (count graphs only)'
      ) do |item_height|
        options[:item_height] = item_height
      end
      opts.on(
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
      opts.on(
        '--background_color BACKGROUNDCOLOR',
        Array,
        "Set the backgroundcolor to be used, ie: 'bin/graph_tool #{DATA_EXAMPLE_ARGS} --background_color Silver"
      ) do |background_color|
        options[:background_color] = background_color
      end
    end
  end
end
