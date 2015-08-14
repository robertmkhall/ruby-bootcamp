require_relative '../../lib/linguine/linguine'
require_relative '../../lib/linguine/bing_translator'

describe Linguine do

  let(:translator) {BingTranslator.new}
  subject(:linguine) { described_class.new(translator) }

  describe '.page' do
    it 'will cache the page' do
      page_name = 'index'
      page_block = Proc.new { puts 'do something' }

      Linguine.page(page_name, &page_block)

      expect(Linguine.pages[page_name]).to eql(page_block)
    end
  end

  describe '#translate_html' do
    let(:path) { 'home.de' }
    let(:expected_translation) { 'some translated text' }
    let(:expected_page_block) { proc {'It does something'} }

    before do
      allow(translator).to receive(:translate).with(expected_page_block.call).and_return(expected_translation)
    end

    it 'will translate the html' do
      Linguine.page(path, &expected_page_block)

      expect(subject.translate_html(path)).to eql(expected_translation)
    end
  end
end