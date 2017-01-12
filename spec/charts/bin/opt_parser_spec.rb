RSpec.describe Charts::OptParser do
  describe 'the parsed options' do
    let(:subject) { parser.parse }
    let(:parser) { Charts::OptParser.new(args) }
    let(:data_args) { Charts::OptParser::DATA_EXAMPLE_ARGS.split(' ') }
    let(:color_args) { Charts::OptParser::COLOR_EXAMPLE_ARGS.split(' ') }
    context 'valid arguments' do
      let(:args) { data_args }
      it { is_expected.to include(data: [8.0, 7.0]) }
      it { is_expected.to include(style: :circle) }
      it { is_expected.to include(type: :svg) }
    end
    context 'a png filename is set' do
      let(:args) { data_args + ['--filename', 'file.png'] }
      it { is_expected.to include(type: :png) }
    end
    context 'type is set' do
      let(:args) { data_args + ['--title', 'Headline'] }
      it { is_expected.to include(title: 'Headline') }
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
    context 'labels are set' do
      let(:args) { data_args + ['--labels', 'label_1,label_2'] }
      it { is_expected.to include(labels: ['label_1', 'label_2']) }
    end
    context 'group-labels are set' do
      let(:args) { data_args + ['--group-labels', 'group_label_1,group_label_2'] }
      it { is_expected.to include(group_labels: ['group_label_1', 'group_label_2']) }
    end
    context 'item-width is set' do
      let(:args) { data_args + ['--item-width', '111'] }
      it { is_expected.to include(item_width: 111) }
    end
    context 'item-height is set' do
      let(:args) { data_args + ['--item-height', '222'] }
      it { is_expected.to include(item_height: 222) }
    end
    context 'background_color is set' do
      let(:args) { data_args + ['--background_color', 'Silver'] }
      it { is_expected.to include(background_color: ['Silver']) }
    end
    context 'no data is set' do
      let(:args) { ['--style', 'circle'] }
      it 'raises an error' do
        expect { subject }.to raise_error(RuntimeError, "No data provided. Please pass in data using the --data flag: 'bin/charts -d 8,7'")
      end
    end
    context 'bar chart one data set is provided' do
      let(:args) { data_args + ['--style', 'bar'] }
      it { is_expected.to include(data: [[8.0, 7.0]]) }
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
