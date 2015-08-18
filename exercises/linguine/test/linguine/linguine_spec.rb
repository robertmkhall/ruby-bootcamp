require_relative '../../lib/linguine/linguine'
require_relative '../../lib/linguine/bing_translator'
require_relative '../../lib/linguine/haml_renderer'

describe Linguine do

  let(:translator) { BingTranslator.new }
  let(:renderer) { HamlRenderer.new }

  subject(:linguine) { (Class.new(described_class)).new(renderer, translator, 'en') }

  describe '.page' do
    it 'will cache the page' do
      page_name = 'index'
      page_block = Proc.new { puts 'do something' }

      subject.class.page(page_name, &page_block)

      expect(subject.pages[page_name]).to eql(page_block)
    end

    it 'will cache the page against multiple paths' do
      page_name_1 = '/'
      page_name_2 = 'home'
      page_block = Proc.new { puts 'do something' }

      subject.class.page(page_name_1, page_name_2, &page_block)

      expect(subject.pages[page_name_1]).to eql(page_block)
      expect(subject.pages[page_name_2]).to eql(page_block)
    end
  end

  describe '#render' do
    let(:view) { 'some_view.haml' }
    let(:args) { {heading: 'some heading value'} }
    let(:rendered_value) { 'rendered html' }

    before do
      allow(renderer).to receive(:render).with(view, args).and_return(rendered_value)
    end

    it 'will call the renderer delegate' do
      expect(subject.render(view, args)).to eql(rendered_value)
    end
  end

  describe '#page_content' do
    let(:path) { 'home' }
    let(:expected_translation) { 'some translated text' }
    let(:expected_page_block) { proc { 'It does something' } }
    let(:language_extension) {'de'}

    before do
      subject.class.page(path, &expected_page_block)
    end

    context 'unknown page found' do
      let(:unknown_url) { 'unknown url' }
      let(:expected_html) { 'some html showing an error' }

      before do
        allow(renderer).to receive(:render)
                               .with(Linguine::UNKNOWN_URL, {content: "Url '#{unknown_url}' is not recognised"})
                               .and_return(expected_html)
      end

      it 'will display an unknown page error' do
        expect(subject.page_content(unknown_url, 'en')).to eql(expected_html)
      end
    end

    context 'language translation not required' do
      it 'will display the default html' do
        expect(subject.page_content(path, nil)).to eql(expected_page_block.call)
      end
    end

    context 'language translation is required' do
      before do
        allow(translator).to receive(:translate)
                                 .with(expected_page_block.call, from: Linguine::ENGLISH, to: language_extension)
                                 .and_return(expected_translation)
      end

      it 'will translate the html' do
        expect(subject.page_content(path, language_extension)).to eql(expected_translation)
      end
    end
  end
end