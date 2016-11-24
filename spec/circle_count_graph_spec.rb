require 'spec_helper'
require 'circle_count_graph'
require 'capybara/rspec'

RSpec.describe CircleCountGraph do
  include Capybara::RSpecMatchers

  let(:data) { { red: 1 } }
  let(:options) { { columns: 2 } }
  let(:graph) { CircleCountGraph.new(data, options) }


end
