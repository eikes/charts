require 'spec_helper'
require 'image_count_graph'
require 'capybara/rspec'

RSpec.describe ImageCountGraph do
  include Capybara::RSpecMatchers

  let(:data) { { red: 1 } }
  let(:options) { { columns: 2 } }
  let(:graph) { ImageCountGraph.new(data, options) }
  let(:svg) { Capybara.string(graph.render) }


  describe '#height and #width' do
    it 'has a width attribute' do
      expect(graph).to respond_to(:width)
    end
    it 'has a height attribute' do
      expect(graph).to respond_to(:height)
    end
    shared_examples 'has a width and height of' do |width, height|
      it "sets the graph.width to #{width}" do
        expect(graph.width).to eq(width)
      end
      it "sets the svg root width to #{width}" do
        expect(svg.find('svg')[:width]).to eq(width.to_s)
      end
      it "sets the graph.height to #{height}" do
        expect(graph.height).to eq(height)
      end
      it "sets the svg root height to #{height}" do
        expect(svg.find('svg')[:height]).to eq(height.to_s)
      end
    end

  end
end
