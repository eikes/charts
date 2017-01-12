module Charts
  class Dispatcher
    attr_reader :options, :chart

    def initialize(options)
      @options = options
      @chart = dispatch
    end

    def render
      if options[:filename]
        chart.render
      else
        puts chart.render
      end
    end

    def dispatch
      if type == :txt
        SymbolCountChart.new(data, chart_options)
      elsif [:svg, :png, :jpg, :gif].include? type
        if style == :circle
          CircleCountChart.new(data, chart_options)
        elsif style == :cross
          CrossCountChart.new(data, chart_options)
        elsif style == :manikin
          ManikinCountChart.new(data, chart_options)
        elsif style == :bar
          BarChart.new(data, chart_options)
        elsif style == :pie
          PieChart.new(data, chart_options)
        end
      end
    end

    def data
      options[:data]
    end

    def chart_options
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
