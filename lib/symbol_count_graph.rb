class SymbolCountGraph
  attr_reader :data, :options, :prepared_data

  def initialize(data, options = { columns: 10 })
    validate_arguments(data, options)
    @data = data
    @options = options
    prepare_data
  end

  def render
    prepared_data.map(&:join).join("\n")
  end

  def validate_arguments(data, options)
    raise ArgumentError if data.empty?
    raise ArgumentError unless data.is_a? Hash
    raise ArgumentError unless options.is_a? Hash
  end

  def prepare_data
    prepared_data = []
    @data.each do |key, value|
      value.times { prepared_data << key.to_s }
    end
    @prepared_data = prepared_data.each_slice(@options[:columns]).to_a
  end
end
