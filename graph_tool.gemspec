Gem::Specification.new do |s|
  s.name        = 'graph_tool'
  s.version     = '0.0.0'
  s.date        = '2016-12-05'
  s.summary     = 'GraphTool renders beautiful graphs'
  s.description = 'A tool to create various kinds of infographics and graphs'
  s.authors     = ['Eike Send', 'Maximilian Maintz']
  s.email       = 'graph_tool@eike.se'
  s.homepage    = 'http://github.com/eikes/graph_tool'
  s.license     = 'MIT'
  s.files       = [
                    'graph_tool/renderer/renderer',
                    'graph_tool/renderer/rvg_renderer',
                    'graph_tool/renderer/svg_renderer',
                    'graph_tool/graph',
                    'graph_tool/bar_chart/grid/grid',
                    'graph_tool/bar_chart/grid/grid_line',
                    'graph_tool/bar_chart/grid/vertical_grid_line',
                    'graph_tool/bar_chart/grid/horizontal_grid_line',
                    'graph_tool/bar_chart/bar_chart',
                    'graph_tool/bar_chart/bar/bar',
                    'graph_tool/bar_chart/bar/vertical_bar',
                    'graph_tool/bar_chart/bar/horizontal_bar',
                    'graph_tool/count_graph/count_graph',
                    'graph_tool/count_graph/circle_count_graph',
                    'graph_tool/count_graph/cross_count_graph',
                    'graph_tool/count_graph/manikin_count_graph',
                    'graph_tool/count_graph/symbol_count_graph',
                    'graph_tool/bin/opt_parser',
                    'graph_tool/bin/dispatcher'
                  ]
  s.bindir      = 'bin'
end
