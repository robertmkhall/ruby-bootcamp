require_relative '../../lib/linguine/linguine'
require_relative '../../lib/linguine/bing_translator'

describe Linguine do

  let(:translator) { BingTranslator.new }
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
    let(:path) { 'home' }
    let(:expected_translation) { 'some translated text' }
    let(:expected_page_block) { proc { 'It does something' } }

    before do
      Linguine.page(path, &expected_page_block)
    end

    context 'language translation is required' do
      before do
        allow(translator).to receive(:translate).with(expected_page_block.call, Linguine::DEFAULT_HTML_LANG, 'de')
                                 .and_return(expected_translation)
      end

      it 'will translate the html' do
        language_extension = '.de'

        expect(subject.translate_html(path + language_extension)).to eql(expected_translation)
      end
    end

    context 'language translation not required' do
      it 'will display the default html' do
        expect(subject.translate_html(path)).to eql(expected_page_block.call)
      end
    end
  end
end