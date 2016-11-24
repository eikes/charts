require 'spec_helper'
require 'circle_count_graph'
require 'capybara/rspec'

RSpec.describe ImageCountGraph do
  include Capybara::RSpecMatchers

  let(:data) { { red: 1 } }
  let(:options) { { columns: 2 } }
  let(:graph) { ImageCountGraph.new(data, options) }


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
      it "sets the graph.height to #{height}" do
        expect(graph.height).to eq(height)
      end
    end
    context 'one circle' do
      let(:data) { { red: 1 } }
      include_examples 'has a width and height of', 20, 20
    end
    context 'one circle with a differen radius' do
      let(:data) { { red: 1 } }
      let(:options) { { radius: 20 } }
      include_examples 'has a width and height of', 40, 40
    end
    context 'one column two circles' do
      let(:data) { { red: 2 } }
      let(:options) { { columns: 1 } }
      include_examples 'has a width and height of', 20, 40
    end
    context 'two columns two circles' do
      let(:data) { { red: 2 } }
      let(:options) { { columns: 2 } }
      include_examples 'has a width and height of', 40, 20
    end
  end

end
