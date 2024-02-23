# frozen_string_literal: true

require 'ccs/components/ccs/header/link'

RSpec.describe CCS::Components::CCS::Header::Link do
  include_context 'and I have a view context'

  let(:header_list_element) { Capybara::Node::Simple.new(result).find('li.ccs-header__navigation-item') }
  let(:header_link_element) { header_list_element.find('a') }

  describe '.render' do
    let(:ccs_header_link) { described_class.new(text: text, li_class: li_class, href: href, context: view_context, **options) }
    let(:result) { ccs_header_link.render }

    let(:text) { 'Here we go' }
    let(:li_class) { 'ccs-header__navigation-item' }
    let(:href) { '/here-we-go' }
    let(:options) { {} }

    let(:default_html) { '<li class="ccs-header__navigation-item"><a class="ccs-header__link" href="/here-we-go">Here we go</a></li>' }

    it 'correctly formats the HTML with the link inside the list element' do
      expect(header_list_element.to_html).to eq(default_html)
    end

    context 'when no options are sent' do
      let(:ccs_table_header_head_cell) { described_class.new(text: text, context: view_context) }

      it 'correctly formats the HTML with the link inside the list element' do
        expect(header_list_element.to_html).to eq(default_html)
      end
    end

    context 'when only the text is passed' do
      let(:ccs_header_link) { described_class.new(text: text, li_class: li_class, context: view_context, **options) }

      it 'has the text in the li without a link' do
        expect(header_list_element).to have_no_css('a', text: 'Here we go')
        expect(header_list_element).to have_content('Here we go')
      end

      context 'when the link is active' do
        let(:options) { { active: true } }

        it 'has the active class' do
          expect(header_list_element[:class]).to eq('ccs-header__navigation-item ccs-header__navigation-item--active')
        end
      end
    end

    context 'when there is a custom class' do
      let(:options) { { attributes: { class: 'my-custom-navigation-item-class' } } }

      it 'does not have the custom class' do
        expect(header_link_element[:class]).to eq('ccs-header__link')
      end
    end

    context 'when there are additional attributes' do
      let(:options) { { attributes: { id: 'my-custom-navigation-item-id', data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(header_link_element[:id]).to eq('my-custom-navigation-item-id')
        expect(header_link_element[:'data-test']).to eq('hello there')
      end
    end
  end
end
