module Charts
end

# Includes:
require_relative 'charts/renderer/renderer'
require_relative 'charts/renderer/rvg_renderer'
require_relative 'charts/renderer/svg_renderer'

# Classes:
require_relative 'charts/chart'
require_relative 'charts/legend'
require_relative 'charts/bar_chart/grid/grid'
require_relative 'charts/bar_chart/grid/grid_line'
require_relative 'charts/bar_chart/grid/vertical_grid_line'
require_relative 'charts/bar_chart/grid/horizontal_grid_line'
require_relative 'charts/bar_chart/bar_chart'
require_relative 'charts/bar_chart/bar/bar'
require_relative 'charts/bar_chart/bar/vertical_bar'
require_relative 'charts/bar_chart/bar/horizontal_bar'
require_relative 'charts/pie_chart/pie_chart'
require_relative 'charts/count_chart/count_chart'
require_relative 'charts/count_chart/circle_count_chart'
require_relative 'charts/count_chart/cross_count_chart'
require_relative 'charts/count_chart/manikin_count_chart'
require_relative 'charts/count_chart/symbol_count_chart'

# Helper for command line charts
require_relative 'charts/bin/opt_parser'
require_relative 'charts/bin/dispatcher'
