class CountGraph

  attr_reader :data, :options, :prepared_data

  def initialize(data, options = {})
    validate_arguments(data, options)
    @data = data
    @options = default_options.merge options
    @prepared_data = prepare_data
  end

  def default_options
    { columns: 10 }
  end

  def validate_arguments(data, options)
    raise ArgumentError if data.empty?
    raise ArgumentError unless data.is_a? Hash
    raise ArgumentError unless options.is_a? Hash
    raise ArgumentError unless data.values.all? { |x| Integer(x) }
  end

  def prepare_data
    prepared_data = []
    data.each do |key, value|
      value.to_i.times { prepared_data << key.to_s }
    end
    prepared_data.each_slice(options[:columns]).to_a
  end

  def render
    raise NotImplementedError
  end

  def save
    raise NotImplementedError
  end

end
