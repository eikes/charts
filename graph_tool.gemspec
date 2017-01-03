Gem::Specification.new do |s|
  s.name        = 'graph_tool'
  s.version     = '0.0.6'
  s.date        = '2016-12-05'
  s.summary     = 'GraphTool renders beautiful graphs'
  s.description = 'A tool to create various kinds of infographics and graphs'
  s.authors     = ['Eike Send', 'Maximilian Maintz']
  s.email       = 'graph_tool@eike.se'
  s.homepage    = 'http://github.com/eikes/graph_tool'
  s.license     = 'MIT'
  s.files       = [
                    'lib/graph_tool/renderer/renderer',
                    'lib/graph_tool/renderer/rvg_renderer',
                    'lib/graph_tool/renderer/svg_renderer',
                    'lib/graph_tool/graph',
                    'lib/graph_tool/legend',
                    'lib/graph_tool/bar_chart/grid/grid',
                    'lib/graph_tool/bar_chart/grid/grid_line',
                    'lib/graph_tool/bar_chart/grid/vertical_grid_line',
                    'lib/graph_tool/bar_chart/grid/horizontal_grid_line',
                    'lib/graph_tool/bar_chart/bar_chart',
                    'lib/graph_tool/bar_chart/bar/bar',
                    'lib/graph_tool/bar_chart/bar/vertical_bar',
                    'lib/graph_tool/bar_chart/bar/horizontal_bar',
                    'lib/graph_tool/pie_chart/pie_chart',
                    'lib/graph_tool/count_graph/count_graph',
                    'lib/graph_tool/count_graph/circle_count_graph',
                    'lib/graph_tool/count_graph/cross_count_graph',
                    'lib/graph_tool/count_graph/manikin_count_graph',
                    'lib/graph_tool/count_graph/symbol_count_graph',
                    'lib/graph_tool/bin/opt_parser',
                    'lib/graph_tool/bin/dispatcher'
                  ]
  s.add_runtime_dependency 'victor'
  s.add_runtime_dependency 'rmagick'
  s.bindir      = 'bin'
end
