# frozen_string_literal: true

require 'ccs/components/govuk/field/inputs/item/checkbox/form'

RSpec.describe CCS::Components::GovUK::Field::Inputs::Item::Checkbox::Form do
  include_context 'and I have a view context'

  let(:checkbox_item_element) { Capybara::Node::Simple.new(result).find('div.govuk-checkboxes__item') }
  let(:checkbox_item_conditional_element) { Capybara::Node::Simple.new(result).find('body') }
  let(:checkbox_item_input_element) { checkbox_item_element.find('input') }
  let(:checkbox_item_label_element) { checkbox_item_element.find('label') }

  describe '.render' do
    include_context 'and I have a form from a model'

    let(:govuk_checkbox_item) { described_class.new(attribute: attribute, value: value, label: label, hint: hint, conditional: conditional, form: form, context: view_context, **options) }
    let(:result) { govuk_checkbox_item.render }

    let(:attribute) { 'ouroboros' }
    let(:value) { 'eunie' }
    let(:label) { { text: 'Eunie' } }
    let(:hint) { nil }
    let(:conditional) { nil }
    let(:options) { {} }

    let(:test_model) { TestModel.new }

    let(:default_html) do
      '
        <div class="govuk-checkboxes__item">
          <input class="govuk-checkboxes__input" type="checkbox" value="eunie" name="test_model[ouroboros][]" id="test_model_ouroboros_eunie">
          <label class="govuk-label govuk-checkboxes__label" for="test_model_ouroboros_eunie">
            Eunie
          </label>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML for the checkbox item' do
        expect(checkbox_item_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:govuk_checkbox_item) { described_class.new(attribute: attribute, value: value, label: label, form: form, context: view_context, **options) }

      it 'correctly formats the HTML for the checkbox item' do
        expect(checkbox_item_element.to_html).to eq(default_html)
      end
    end

    context 'when the item is checked' do
      before { test_model.ouroboros = ['mio', 'eunie'] }

      it 'checks the checbox' do
        expect(checkbox_item_input_element).to be_checked
      end
    end

    context 'when the value us an iregular value' do
      let(:value) { 'Zeke Von Gembu, Bringer of Chaos' }

      it 'is able to format an ID' do
        expect(checkbox_item_input_element[:id]).to eq('test_model_ouroboros_zeke_von_gembu_bringer_of_chaos')
        expect(checkbox_item_label_element[:for]).to eq('test_model_ouroboros_zeke_von_gembu_bringer_of_chaos')
      end
    end

    context 'and it has a custom ID' do
      let(:options) { { attributes: { id: 'my-custom-checkbox-item-id' } } }

      it 'is overwrites the ID of the checkbox item' do
        expect(checkbox_item_input_element[:id]).to eq('my-custom-checkbox-item-id')
        expect(checkbox_item_label_element[:for]).to eq('my-custom-checkbox-item-id')
      end
    end

    context 'and it has a custom name' do
      let(:options) { { attributes: { name: 'my-custom-checkbox-item-name' } } }

      it 'overwrites the ID of the checkbox item' do
        expect(checkbox_item_input_element[:name]).to eq('my-custom-checkbox-item-name')
      end
    end

    context 'and we consider the checkbox item label' do
      context 'and it has custom classes' do
        let(:label) do
          {
            text: 'Noah',
            classes: 'my-custom-label-class'
          }
        end

        it 'adds to the class of the checkbox item label' do
          expect(checkbox_item_label_element[:class]).to eq('govuk-label govuk-checkboxes__label my-custom-label-class')
        end
      end

      context 'when the checkbox item label has custom attributes' do
        let(:label) do
          {
            text: 'Noah',
            attributes: {
              id: 'my-custom-label-id',
              data: {
                test: 'custom-data-attribute'
              }
            }
          }
        end

        it 'has the custom attributes on the label' do
          expect(checkbox_item_label_element[:id]).to eq('my-custom-label-id')
          expect(checkbox_item_label_element[:'data-test']).to eq('custom-data-attribute')
        end
      end
    end

    context 'when the checkbox item has a hint' do
      let(:hint) do
        {
          text: 'Come on, who else?'
        }.merge(hint_options)
      end
      let(:hint_options) { {} }

      it 'renders the checkbox item with the hint' do
        expect(checkbox_item_element.to_html).to eq('
          <div class="govuk-checkboxes__item">
            <input class="govuk-checkboxes__input" aria-describedby="ouroboros_eunie-item-hint" type="checkbox" value="eunie" name="test_model[ouroboros][]" id="test_model_ouroboros_eunie">
            <label class="govuk-label govuk-checkboxes__label" for="test_model_ouroboros_eunie">
              Eunie
            </label>
            <div id="ouroboros_eunie-item-hint" class="govuk-hint govuk-checkboxes__hint">
              Come on, who else?
            </div>
          </div>
        '.to_one_line)
      end

      context 'and the hint has custom ID' do
        let(:hint_options) { { attributes: { id: 'custom-checkbox-item-hint-id' } } }

        it 'renders the checkbox item with the custom hint ID' do
          expect(checkbox_item_input_element[:'aria-describedby']).to eq('custom-checkbox-item-hint-id')
          expect(checkbox_item_element.find('div.govuk-hint')[:id]).to eq('custom-checkbox-item-hint-id')
        end
      end
    end

    context 'when there is conditional content within the item' do
      let(:conditional) do
        {
          content: 'Hello there!'
        }.merge(conditional_options)
      end
      let(:conditional_options) { {} }

      it 'correctly formats the HTML with the conditional item' do
        expect(checkbox_item_conditional_element.to_html).to eq('
          <body>
            <div class="govuk-checkboxes__item">
              <input class="govuk-checkboxes__input" data-aria-controls="conditional-ouroboros_eunie" type="checkbox" value="eunie" name="test_model[ouroboros][]" id="test_model_ouroboros_eunie">
              <label class="govuk-label govuk-checkboxes__label" for="test_model_ouroboros_eunie">
                Eunie
              </label>
            </div>
            <div class="govuk-checkboxes__conditional govuk-checkboxes__conditional--hidden" id="conditional-ouroboros_eunie">
              Hello there!
            </div>
          </body>
        '.to_one_line)
      end

      context 'when the item is checked' do
        let(:options) { { checked: true } }

        it 'does not hide the conditional content' do
          expect(checkbox_item_conditional_element.find_by_id('conditional-ouroboros_eunie')[:class]).to eq('govuk-checkboxes__conditional')
        end
      end

      context 'when a custom ID is passed' do
        let(:conditional_options) { { attributes: { id: 'my-custom-conditional-id' } } }

        it 'has the custom id' do
          expect(checkbox_item_input_element[:'data-aria-controls']).to eq('my-custom-conditional-id')
          expect(checkbox_item_conditional_element.find('div.govuk-checkboxes__conditional')[:id]).to eq('my-custom-conditional-id')
        end
      end

      context 'when there are other data attributes' do
        let(:options) { { attributes: { data: { test: 'data-test' } } } }

        it 'has the both data attributes on the input' do
          expect(checkbox_item_input_element[:'data-test']).to eq('data-test')
          expect(checkbox_item_input_element[:'data-aria-controls']).to eq('conditional-ouroboros_eunie')
        end
      end
    end
  end
end
