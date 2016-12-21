class GraphTool::BarGraph::Bar
  attr_reader :graph, :data_value, :set_nr, :bar_nr_in_set

  def initialize(graph, data_value, set_nr, bar_nr_in_set)
    @graph = graph
    @data_value = data_value
    @set_nr = set_nr
    @bar_nr_in_set = bar_nr_in_set
  end

  def draw
    graph.renderer.rect x, y, width, height, fill: graph.colors[set_nr], class: 'bar'
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

  def bar_number_in_graph
    set_nr + bar_nr_in_set * graph.set_count
  end
end
