class Charts::BarChart::Bar
  attr_reader :chart, :data_value, :set_nr, :bar_nr_in_set

  def initialize(chart, data_value, set_nr, bar_nr_in_set)
    @chart = chart
    @data_value = data_value
    @set_nr = set_nr
    @bar_nr_in_set = bar_nr_in_set
  end

  def draw
    chart.renderer.rect x, y, width, height, fill: chart.colors[set_nr], class: 'bar'
  end

  def x
    raise NotImplementedError
  end

  def y
    raise NotImplementedError
  end

  def width
    raise NotImplementedError
  end

  def height
    raise NotImplementedError
  end

  def bar_number_in_chart
    set_nr + bar_nr_in_set * chart.set_count
  end
end
