require 'spec_helper'

RSpec.describe GraphTool::OptParser do
  describe 'the parsed options' do
    let(:subject) { parser.parse }
    let(:parser) { GraphTool::OptParser.new(args) }
    let(:data_args) { GraphTool::OptParser::DATA_EXAMPLE_ARGS.split(' ') }
    let(:color_args) { GraphTool::OptParser::COLOR_EXAMPLE_ARGS.split(' ') }
    context 'valid arguments' do
      let(:args) { data_args }
      it { is_expected.to include(data: ['8', '7']) }
      it { is_expected.to include(style: :circle) }
      it { is_expected.to include(type: :svg) }
    end
    context 'a png filename is set' do
      let(:args) { data_args + ['--filename', 'file.png'] }
      it { is_expected.to include(type: :png) }
    end
    context 'type is set' do
      let(:args) { data_args + ['--type', 'png'] }
      it { is_expected.to include(type: :png) }
    end
    context 'columns are set' do
      let(:args) { data_args + ['--columns', '2'] }
      it { is_expected.to include(columns: 2) }
    end
    context 'colors are set' do
      let(:args) { data_args + color_args }
      it { is_expected.to include(colors: ['red', 'gold']) }
    end
    context 'item-width is set' do
      let(:args) { data_args + ['--item-width', '111'] }
      it { is_expected.to include(item_width: 111) }
    end
    context 'item-height is set' do
      let(:args) { data_args + ['--item-height', '222'] }
      it { is_expected.to include(item_height: 222) }
    end
    context 'no data is set' do
      let(:args) { ['--style', 'circle'] }
      it 'raises an error' do
        expect { subject }.to raise_error(RuntimeError, "No data provided. Please pass in data using the --data flag: 'bin/graph_tool -d 8,7'")
      end
    end
    context 'a filename is set with an unknown extension' do
      let(:args) { data_args + ['--filename', 'file.pdf'] }
      it 'raises an error' do
        expect { subject }.to raise_error(RuntimeError, "No type provided. Set a type with --type flag or by setting a valid --filename")
      end
    end
    context 'no arguments' do
      let(:args) { [] }
      it 'prints the help instructions' do
        expect($stdout).to receive(:puts)
        subject
      end
    end
  end
end
