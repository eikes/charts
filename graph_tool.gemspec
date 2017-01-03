Gem::Specification.new do |s|
  s.name        = 'graph_tool'
  s.version     = '0.0.7'
  s.date        = '2016-12-05'
  s.summary     = 'GraphTool renders beautiful graphs'
  s.description = 'A tool to create various kinds of infographics and graphs'
  s.authors     = ['Eike Send', 'Maximilian Maintz']
  s.email       = 'graph_tool@eike.se'
  s.homepage    = 'http://github.com/eikes/graph_tool'
  s.license     = 'MIT'
  s.files       = Dir['lib/**/*.rb']
  s.add_runtime_dependency 'victor'
  s.add_runtime_dependency 'rmagick'
  s.bindir      = 'bin'
end
