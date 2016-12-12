RSpec.describe GraphTool::Grid do
  let(:options) { {} }
  let(:graph) { GraphTool::BarGraph.new(data, options) }

  describe '#number_of_grid_lines' do
    let(:subject) { graph.number_of_grid_lines }
    context 'for numbers betweem 0 and 1' do
      let(:data) { [[0, 1]] }
      it { is_expected.to eq 5 }
    end
    context 'for numbers betweem 0 and 2' do
      let(:data) { [[0, 2]] }
      it { is_expected.to eq 4 }
    end
    context 'for numbers betweem 0 and 3' do
      let(:data) { [[0, 3]] }
      it { is_expected.to eq 3 }
    end
    context 'for numbers betweem 0 and 4' do
      let(:data) { [[0, 4]] }
      it { is_expected.to eq 4 }
    end
  end

  describe '#grid_line_values' do
    let(:subject) { graph.grid_line_values }
    context 'for numbers betweem 0 and 1' do
      let(:data) { [[0, 1]] }
      it { is_expected.to eq [0.0, 0.2, 0.4, 0.6, 0.8, 1.0] }
    end
    context 'for numbers betweem 0 and 2' do
      let(:data) { [[0, 2]] }
      it { is_expected.to eq [0.0, 0.5, 1.0, 1.5, 2.0] }
    end
    context 'for numbers betweem 0 and 3' do
      let(:data) { [[0, 3]] }
      it { is_expected.to eq [0.0, 1.0, 2.0, 3.0] }
    end
    context 'for numbers betweem 0 and 4' do
      let(:data) { [[0, 4]] }
      it { is_expected.to eq [0.0, 1.0, 2.0, 3.0, 4.0] }
    end
    context 'for numbers betweem 0 and 10' do
      let(:data) { [[0, 10]] }
      it { is_expected.to eq [0.0, 2.0, 4.0, 6.0, 8.0, 10.0] }
    end
    context 'for numbers betweem 0 and 55' do
      let(:data) { [[0, 55]] }
      it { is_expected.to eq [0, 10, 20, 30, 40, 50] }
    end
    context 'for numbers betweem 0 and 0.1' do
      let(:data) { [[0, 0.1]] }
      it { is_expected.to eq [0.0, 0.02, 0.04, 0.06, 0.08, 0.1] }
    end
    context 'for numbers betweem 0 and 1000' do
      let(:data) { [[0, 1000]] }
      it { is_expected.to eq [0.0, 200.0, 400.0, 600.0, 800.0, 1000.0] }
    end
    context 'for numbers betweem 1000 and 2000' do
      let(:options) { { min: 1000 } }
      let(:data) { [[1000, 2000]] }
      it { is_expected.to eq [1000.0, 1200.0, 1400.0, 1600.0, 1800.0, 2000.0] }
    end
    context 'for numbers betweem 0 and -1' do
      let(:data) { [[0, -1]] }
      it { is_expected.to eq [-1.0, -0.8, -0.6, -0.4, -0.2, 0.0] }
    end
    context 'for numbers betweem 0 and -1' do
      let(:data) { [[0, -10]] }
      it { is_expected.to eq [-10, -8, -6, -4, -2, 0] }
    end
    context 'for numbers betweem -1 and 1' do
      let(:data) { [[-1, 1]] }
      it { is_expected.to eq [-1.0, -0.5, 0.0, 0.5, 1.0] }
    end
  end

end
