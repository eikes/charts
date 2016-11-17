class SymbolCountGraph
  attr_reader :data, :options

  def initialize(data, options = { columns: 10 })
    validate_arguments(data, options)
    @data = data
    @options = options
  end

  def render
    result = ''
    @data.each { |key, value| result << key.to_s * value }
    result.scan(/.{1,#{@options[:columns]}}/).join("\n")
  end

  def validate_arguments(data, options)
    raise ArgumentError if data.empty?
    raise ArgumentError unless data.is_a? Hash
    raise ArgumentError unless options.is_a? Hash
  end
end
