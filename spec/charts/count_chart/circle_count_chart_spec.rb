RSpec.describe Charts::CircleCountChart do
  let(:data) { [1] }
  let(:graph) { Charts::CircleCountChart.new(data, options) }
  let(:svg) { Nokogiri::XML(graph.render) }
  let(:columns) { 2 }
  let(:inner_margin) { 0 }
  let(:outer_margin) { 0 }
  let(:item_width) { 20 }
  let(:item_height) { 20 }
  let(:type) { :svg }
  let(:background_color) { 'white' }
  let(:colors) { ['green'] }
  let(:labels) { [] }
  let(:options) do
    {
      columns:          columns,
      item_width:       item_width,
      item_height:      item_height,
      inner_margin:     inner_margin,
      outer_margin:     outer_margin,
      type:             type,
      background_color: background_color,
      colors:           colors,
      labels:           labels
    }
  end

  describe 'setup' do
    it 'sets the SVG header' do
      expect(graph.render).to match(/DOCTYPE svg PUBLIC/)
    end
  end

  context 'background color default' do
    it 'has white as default background-color' do
      expect(svg.at_css('rect.background_color')[:fill]).to eq('white')
    end
  end

  context 'background-color' do
    let(:background_color) { 'red' }
    it 'sets background-color correctly' do
      expect(svg.at_css('rect.background_color')[:fill]).to eq('red')
    end
  end

  describe '#height and #width' do
    shared_examples 'has a width and height of' do |width, height|
      it "sets the svg root width to #{width}" do
        expect(svg.at_css('svg')[:width]).to eq(width.to_s)
      end
      it "sets the svg root height to #{height}" do
        expect(svg.at_css('svg')[:height]).to eq(height.to_s)
      end
    end
    context 'one circle' do
      include_examples 'has a width and height of', 20, 20
    end
    context 'one circle with a different width' do
      let(:item_width) { 40 }
      let(:item_height) { 40 }
      include_examples 'has a width and height of', 40, 40
    end
    context 'one column two circles' do
      let(:data) { [2] }
      let(:columns) { 1 }
      include_examples 'has a width and height of', 20, 40
    end
    context 'two columns two circles' do
      let(:data) { [2] }
      include_examples 'has a width and height of', 40, 20
    end
  end

  describe '#height and #width with inner-margin' do
    shared_examples 'has a width and height of' do |width, height|
      it "sets the svg root width to #{width}" do
        expect(svg.at_css('svg')[:width]).to eq(width.to_s)
      end
      it "sets the svg root height to #{height}" do
        expect(svg.at_css('svg')[:height]).to eq(height.to_s)
      end
    end
    context 'one circle with an inner-margin of 100' do
      let(:inner_margin) { 100 }
      include_examples 'has a width and height of', 220, 220
    end
    context 'one circle with a width and height of 40 and an
    inner-margin of 100' do
      let(:inner_margin) { 100 }
      let(:item_width) { 40 }
      let(:item_height) { 40 }
      include_examples 'has a width and height of', 240, 240
    end
    context 'two circles with an inner-margin of 100 in one column ' do
      let(:data) { [2] }
      let(:columns) { 1 }
      let(:inner_margin) { 100 }
      include_examples 'has a width and height of', 220, 440
    end
    context 'two circles with an inner-margin of 100 in two columns' do
      let(:data) { [2] }
      let(:columns) { 2 }
      let(:inner_margin) { 100 }
      include_examples 'has a width and height of', 440, 220
    end
  end

  describe '#height and #width with outer-margin' do
    shared_examples 'has a width and height of' do |width, height|
      it "sets the svg root width to #{width}" do
        expect(svg.at_css('svg')[:width]).to eq(width.to_s)
      end
      it "sets the svg root height to #{height}" do
        expect(svg.at_css('svg')[:height]).to eq(height.to_s)
      end
    end
    context 'one circle with an outer-margin of 500' do
      let(:outer_margin) { 500 }
      include_examples 'has a width and height of', 1020, 1020
    end
    context 'one circle with a width and height of 40 and an
    outer-margin of 500' do
      let(:outer_margin) { 500 }
      let(:item_width) { 40 }
      let(:item_height) { 40 }
      include_examples 'has a width and height of', 1040, 1040
    end
    context 'two circles with an outer-margin of 500 in one column' do
      let(:data) { [2] }
      let(:columns) { 1 }
      let(:outer_margin) { 500 }
      include_examples 'has a width and height of', 1020, 1040
    end
    context 'two circles with an outer-margin of 100 in two columns' do
      let(:data) { [2] }
      let(:columns) { 2 }
      let(:outer_margin) { 500 }
      include_examples 'has a width and height of', 1040, 1020
    end
  end

  describe '#height and #width with inner- and outer-margin' do
    shared_examples 'has a width and height of' do |width, height|
      it "sets the svg root width to #{width}" do
        expect(svg.at_css('svg')[:width]).to eq(width.to_s)
      end
      it "sets the svg root height to #{height}" do
        expect(svg.at_css('svg')[:height]).to eq(height.to_s)
      end
    end
    context 'one circle with an inner-margin of 100 and an
    outer-margin of 500' do
      let(:inner_margin) { 100 }
      let(:outer_margin) { 500 }
      include_examples 'has a width and height of', 1220, 1220
    end
    context 'one circle with a width and height of 40, a inner-margin of 100
    and an outer-margin of 500' do
      let(:inner_margin) { 100 }
      let(:outer_margin) { 500 }
      let(:item_width) { 40 }
      let(:item_height) { 40 }
      include_examples 'has a width and height of', 1240, 1240
    end
    context 'two circles with an inner-margin of 100 and an
    outer-margin of 500 in one column' do
      let(:data) { [2] }
      let(:columns) { 1 }
      let(:inner_margin) { 100 }
      let(:outer_margin) { 500 }
      include_examples 'has a width and height of', 1220, 1440
    end
    context 'two circles with an inner-margin of 100 and an
    outer-margin of 100 in two columns' do
      let(:data) { [2] }
      let(:columns) { 2 }
      let(:inner_margin) { 100 }
      let(:outer_margin) { 500 }
      include_examples 'has a width and height of', 1440, 1220
    end
  end
  describe 'root element' do
    it 'exists' do
      expect(svg.at_css('svg')).not_to be_nil
    end
  end

  context 'one circle' do
    let(:data) { [1] }
    let(:colors) { ['#FACADE'] }
    let(:item_width) { 100 }
    let(:circle) { svg.at_css('circle') }
    it 'renders one circle with the correct color' do
      expect(circle[:fill]).to eq('#FACADE')
    end
    it 'renders a circle with a given radius of 50 (half item_width)' do
      expect(circle[:r]).to eq('50')
    end
  end

  context 'two different circles' do
    let(:data) { [1, 1] }
    let(:colors) { ['red', 'green'] }
    let(:red_circle) { svg.css('circle').first }
    let(:green_circle) { svg.css('circle').last }
    it 'renders two circles' do
      expect(svg.css('circle').count).to eq(2)
    end
    it 'renders one red circle' do
      expect(red_circle[:fill]).to eq('red')
    end
    it 'renders the red circle on the left' do
      expect(red_circle[:cx]).to eq('10')
    end
    it 'renders the red circle on the top' do
      expect(red_circle[:cy]).to eq('10')
    end

    it 'renders one green circle' do
      expect(green_circle[:fill]).to eq('green')
    end
    it 'renders the green circle on the right' do
      expect(green_circle[:cx]).to eq('30')
    end
    it 'renders the green circle on the top' do
      expect(green_circle[:cy]).to eq('10')
    end
  end

  context 'one circle with inner-margin' do
    let(:inner_margin) { 2 }
    let(:data) { [1] }
    let(:colors) { ['#FACADE'] }
    let(:circle) { svg.at_css('circle') }
    it 'renders the correct position on x-axis of a circle with inner-margin' do
      expect(circle[:cx]).to eq('12')
    end
    it 'renders the correct position on y-axis of a circle with inner-margin' do
      expect(circle[:cy]).to eq('12')
    end
  end

  context 'two circles in one column with inner-margin' do
    let(:inner_margin) { 2 }
    let(:columns) { 1 }
    let(:data) { [1, 1] }
    let(:colors) { ['red', 'green'] }
    let(:red_circle) { svg.css('circle').first }
    let(:green_circle) { svg.css('circle').last }
    it 'renders the correct position of red circle with inner-margin' do
      expect(red_circle[:cx]).to eq('12')
      expect(red_circle[:cy]).to eq('12')
    end
    it 'renders the correct position of green circle with inner-margin' do
      expect(green_circle[:cx]).to eq('12')
      expect(green_circle[:cy]).to eq('36')
    end
  end

  context 'two circles in two columns with inner-margin' do
    let(:inner_margin) { 2 }
    let(:data) { [1, 1] }
    let(:colors) { ['red', 'green'] }
    let(:red_circle) { svg.css('circle').first }
    let(:green_circle) { svg.css('circle').last }
    it 'renders the correct position of red circle with inner-margin' do
      expect(red_circle[:cx]).to eq('12')
      expect(red_circle[:cy]).to eq('12')
    end
    it 'renders the correct position of green circle with inner-margin' do
      expect(green_circle[:cx]).to eq('36')
      expect(green_circle[:cy]).to eq('12')
    end
  end

  context 'two circles in one column with outer-margin' do
    let(:outer_margin) { 20 }
    let(:columns) { 1 }
    let(:data) { [1, 1] }
    let(:colors) { ['red', 'green'] }
    let(:red_circle) { svg.css('circle').first }
    let(:green_circle) { svg.css('circle').last }
    it 'renders the correct position of red circle with outer-margin' do
      expect(red_circle[:cx]).to eq('30')
      expect(red_circle[:cy]).to eq('30')
    end
    it 'renders the correct position of green circle with outer-margin' do
      expect(green_circle[:cx]).to eq('30')
      expect(green_circle[:cy]).to eq('50')
    end
  end

  context 'two circles in one column with inner- and outer-margin' do
    let(:inner_margin) { 2 }
    let(:outer_margin) { 20 }
    let(:columns) { 1 }
    let(:data) { [1, 1] }
    let(:colors) { ['red', 'green'] }
    let(:red_circle) { svg.css('circle').first }
    let(:green_circle) { svg.css('circle').last }
    it 'renders the correct position of red circle with inner- and outer-margin' do
      expect(red_circle[:cx]).to eq('32')
      expect(red_circle[:cy]).to eq('32')
    end
    it 'renders the correct position of green circle with inner- and outer-margin' do
      expect(green_circle[:cx]).to eq('32')
      expect(green_circle[:cy]).to eq('56')
    end
  end

context 'label-items' do
  describe 'position of labels-items' do
    let(:data) { [1, 1] }
    let(:labels) { ['See', 'Fire'] }
    let(:colors) { ['red', 'green'] }
    let(:item_height) { 10 }
    let(:columns) { 1 }
    let(:first_graph_circle_cy) { svg.css('circle')[0][:cy].to_i }
    let(:second_graph_circle_cy) { svg.css('circle')[1][:cy].to_i }
    let(:first_label_circle_cy) { svg.css('circle')[2][:cy].to_i }
    let(:second_label_circle_cy) { svg.css('circle')[3][:cy].to_i }
    it 'renders first label-circle two lengths underneath last graph-circle' do
      expect(first_graph_circle_cy).to eq(5)
      expect(second_graph_circle_cy).to eq(15)
      expect(first_label_circle_cy).to eq(35)
    end
    it 'renders label-circles with the same height-distance as graph-circles' do
      expect(second_graph_circle_cy - first_graph_circle_cy).to eq(second_label_circle_cy - first_label_circle_cy)
    end
  end
end

context 'label-text' do
  let(:data) { [2, 2] }
  let(:labels) { ['See', 'Fire'] }
  let(:colors) { ['red', 'green'] }
  describe 'presence of label-text' do
    it 'renders two labels for two different types of circles' do
      expect(svg.css('text.label_text').count).to eq(2)
    end
  end
  describe 'style of label-text' do
    it 'renders labels with a default font-size of 16' do
      expect(svg.css('text.label_text').first[:'font-size']).to eq('16')
    end
    it 'renders labels with a default font-family of arial' do
      expect(svg.css('text.label_text').first[:'font-family']).to eq('arial')
    end
  end
end



context 'filename is set' do
  let(:options) { { filename: 'dots.svg' } }
  it 'calls #save on the SVG' do
    expect_any_instance_of(SVG).to receive(:save)
    graph.render
  end
end

describe 'rmagick renderer' do
  let(:background_color) { 'green' }
  let(:graph) { Charts::CircleCountChart.new(data, options) }
  let(:data) { [1] }
  let(:colors) { ['red'] }
  let(:type) { :png }

  it 'calls #circle on Magick::RVG' do
    expect_any_instance_of(Magick::RVG).to receive(:circle).with(10, 10, 10).and_return(double(styles: nil))
    graph.render
  end

  it 'calls #styles on Magick::RVG::Circle' do
    expect_any_instance_of(Magick::RVG::Circle).to receive(:styles).with(fill: 'red')
    graph.render
  end

  context 'filename is set' do
    let(:options) { { type: :png, filename: 'dots.jpg' } }
    it 'calls #write on Magick::Image' do
      expect_any_instance_of(Magick::Image).to receive(:write)
      graph.render
    end
  end
end
end
