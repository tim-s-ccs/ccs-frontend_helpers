# frozen_string_literal: true

require 'ccs/components/govuk/warning_text'

RSpec.describe CCS::Components::GovUK::WarningText do
  include_context 'and I have a view context'

  let(:warning_text_element) { Capybara::Node::Simple.new(result).find('div.govuk-warning-text') }

  describe '.render' do
    let(:govuk_warning_text) { described_class.new(text: text, context: view_context, **options) }
    let(:result) { govuk_warning_text.render }

    let(:text) { 'You cannot go beyond here' }
    let(:options) { {} }

    let(:default_html) do
      '
        <div class="govuk-warning-text">
          <span class="govuk-warning-text__icon" aria-hidden="true">!</span>
          <strong class="govuk-warning-text__text">
            <span class="govuk-visually-hidden">Warning</span>
            You cannot go beyond here
          </strong>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the warning text' do
        expect(warning_text_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:govuk_warning_text) { described_class.new(text: text, context: view_context) }

      it 'correctly formats the HTML with the warning text' do
        expect(warning_text_element.to_html).to eq(default_html)
      end
    end

    context 'when there is no text but there is a block' do
      let(:govuk_warning_text) { described_class.new(context: view_context, **options) }

      let(:result) do
        govuk_warning_text.render do
          view_context.concat(tag.span('You cannot go beyond here.'))
          view_context.concat(tag.span('And we mean it this time!'))
        end
      end

      it 'correctly formats the HTML with the warning HTML' do
        expect(warning_text_element.to_html).to eq(
          '
            <div class="govuk-warning-text">
              <span class="govuk-warning-text__icon" aria-hidden="true">!</span>
              <strong class="govuk-warning-text__text">
                <span class="govuk-visually-hidden">Warning</span>
                <span>You cannot go beyond here.</span>
                <span>And we mean it this time!</span>
              </strong>
            </div>
          '.to_one_line
        )
      end
    end

    context 'when there is custom icon fallback text' do
      let(:options) { { icon_fallback_text: 'Do not worry' } }

      it 'has the custom icon fallback text' do
        expect(warning_text_element).to have_css('span.govuk-visually-hidden', text: 'Do not worry')
      end
    end

    context 'when an ID is passed as an attribute' do
      let(:options) { { attributes: { id: 'ouroboros-warning-text' } } }

      it 'has the id' do
        expect(warning_text_element[:id]).to eq('ouroboros-warning-text')
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(warning_text_element[:class]).to eq('govuk-warning-text my-custom-class')
      end
    end

    context 'when additional data attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(warning_text_element[:'data-test']).to eq('hello there')
      end
    end
  end
end
