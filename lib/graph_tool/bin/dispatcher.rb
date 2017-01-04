module GraphTool
  class Dispatcher
    attr_reader :options

    def initialize(options)
      @options = options
    end

    def render
      if options[:filename]
        graph.render
      else
        puts graph.render
      end
    end

    def graph
      if type == :txt
        SymbolCountGraph.new(data, graph_options)
      elsif [:svg, :png, :jpg, :gif].include? type
        if style == :circle
          CircleCountGraph.new(data, graph_options)
        elsif style == :cross
          CrossCountGraph.new(data, graph_options)
        elsif style == :manikin
          ManikinCountGraph.new(data, graph_options)
        elsif style == :bar
          BarChart.new(data, graph_options)
        elsif style == :pie
          PieChart.new(data, graph_options)
        end
      end
    end

    def data
      options[:data]
    end

    def graph_options
      options.select do |key, _value|
        [
          :background_color,
          :colors,
          :columns,
          :filename,
          :group_labels,
          :height,
          :item_height,
          :item_width,
          :labels,
          :title,
          :type,
          :width
        ].include? key
      end
    end

    def type
      options[:type].to_sym
    end

    def style
      options[:style].to_sym
    end
  end
end
