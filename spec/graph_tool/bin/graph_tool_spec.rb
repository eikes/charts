require 'spec_helper'

RSpec.describe 'bin/graph_tool' do
  let(:graph) { dispatcher.graph }
  let(:dispatcher) { GraphTool::Dispatcher.new(options) }
  let(:options) { parser.parse }
  let(:parser) { GraphTool::OptParser.new(args) }
  let(:data_args) { GraphTool::OptParser::DATA_EXAMPLE_ARGS.split(' ') }
  let(:color_args) { GraphTool::OptParser::COLOR_EXAMPLE_ARGS.split(' ') }

  context 'data args are provided' do
    let(:args) { data_args }
    it 'creates an svg output' do
      expect(graph.render).to match(/DOCTYPE svg PUBLIC/)
    end
  end

  context 'data and colors args are provided' do
    let(:args) { data_args + color_args }
    it 'creates an svg output' do
      expect(graph.render).to match(/red/)
      expect(graph.render).to match(/gold/)
    end
  end

end
