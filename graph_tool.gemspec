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
                   'lib/graph_tool.rb',
                   'lib/graph_tool/image_renderer.rb',
                   'lib/graph_tool/graph.rb',
                   'lib/graph_tool/bar_graph/bar_graph.rb',
                   'lib/graph_tool/bar_graph/bar.rb',
                   'lib/graph_tool/count_graph/count_graph.rb',
                   'lib/graph_tool/count_graph/circle_count_graph.rb',
                   'lib/graph_tool/count_graph/cross_count_graph.rb',
                   'lib/graph_tool/count_graph/manikin_count_graph.rb',
                   'lib/graph_tool/count_graph/symbol_count_graph.rb'
                  ]
  s.bindir      = 'bin'
end
