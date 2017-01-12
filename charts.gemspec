Gem::Specification.new do |s|
  s.name        = 'charts'
  s.version     = '0.0.10'
  s.date        = '2017-01-04'
  s.summary     = 'Renders beautiful charts'
  s.description = 'Create charts, graphs and info chartics with ruby as SVG, JPG or PNG images'
  s.authors     = ['Eike Send', 'Maximilian Maintz']
  s.email       = 'charts@eike.se'
  s.homepage    = 'http://github.com/eikes/charts'
  s.license     = 'MIT'
  s.files       = Dir['lib/**/*.rb']
  s.bindir      = 'bin'
  s.add_runtime_dependency 'victor', '~> 0.1.3'
  s.add_runtime_dependency 'rmagick', '~> 2.0'
end
