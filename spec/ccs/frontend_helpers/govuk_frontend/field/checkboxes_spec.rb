# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/field/checkboxes'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Field::Checkboxes, type: :helper do
  include described_class

  let(:form_group_element) { Capybara::Node::Simple.new(result).find('div.govuk-form-group') }
  let(:fieldset_element) { Capybara::Node::Simple.new(result).find('fieldset.govuk-fieldset') }
  let(:legend_element) { Capybara::Node::Simple.new(result).find('legend.govuk-fieldset__legend') }
  let(:hint_element) { Capybara::Node::Simple.new(result).find('div.govuk-hint') }
  let(:error_message_element) { Capybara::Node::Simple.new(result).find('p.govuk-error-message') }
  let(:checkboxes_element) { Capybara::Node::Simple.new(result).find('div.govuk-checkboxes') }
  let(:checkbox_item_elements) { checkboxes_element.all('div.govuk-checkboxes__item') }

  let(:attribute) { 'ouroboros' }
  let(:checkbox_items) do
    [
      {
        value: 'noah',
        label: {
          text: 'Noah'
        }
      },
      {
        value: 'mio',
        label: {
          text: 'Mio'
        }
      },
      {
        value: 'eunie',
        label: {
          text: 'Eunie'
        }
      },
      {
        value: 'taion',
        label: {
          text: 'Taion'
        }
      },
      {
        value: 'lanz',
        label: {
          text: 'Lanz'
        }
      },
      {
        value: 'sena',
        label: {
          text: 'Sena'
        }
      }
    ]
  end
  let(:single_checkbox_item) do
    [
      {
        value: 'eunie',
        label: {
          text: 'Eunie'
        }
      }
    ]
  end
  let(:conditional_checkbox_item) do
    [
      {
        value: 'eunie',
        label: {
          text: 'Eunie'
        },
        conditional: {
          content: 'Hello there!'
        }
      }
    ]
  end
  let(:options) do
    {
      form_group: form_group_options,
      fieldset: {
        legend: {
          text: 'Select your favourite characters',
        }.merge(legend_options),
      }.merge(fieldset_options),
      checkboxes: checkboxes_options
    }
  end
  let(:minimum_options) do
    {
      fieldset: {
        legend: {
          text: 'Select your favourite characters'
        }
      }
    }
  end
  let(:options_with_hint) do
    {
      form_group: form_group_options,
      fieldset: {
        legend: {
          text: 'Select your favourite characters',
        },
      }.merge(fieldset_options),
      hint: {
        text: 'Pick at least one option from the list'
      }.merge(hint_options),
      checkboxes: checkboxes_options
    }
  end
  let(:form_group_options) { {} }
  let(:fieldset_options) { {} }
  let(:legend_options) { {} }
  let(:hint_options) { {} }
  let(:checkboxes_options) { {} }
  let(:model) { TestModel.new }

  describe '.govuk_checkboxes' do
    let(:result) { govuk_checkboxes(attribute, checkbox_items, error_message: error_message, **options) }
    let(:error_message) { nil }

    let(:default_html) do
      '
        <div class="govuk-form-group" id="ouroboros-form-group">
          <fieldset class="govuk-fieldset">
            <legend class="govuk-fieldset__legend">
              Select your favourite characters
            </legend>
            <div class="govuk-checkboxes" data-module="govuk-checkboxes">
              <div class="govuk-checkboxes__item">
                <input type="checkbox" name="ouroboros[]" id="ouroboros_noah" value="noah" class="govuk-checkboxes__input">
                <label class="govuk-label govuk-checkboxes__label" for="ouroboros_noah">
                  Noah
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input type="checkbox" name="ouroboros[]" id="ouroboros_mio" value="mio" class="govuk-checkboxes__input">
                <label class="govuk-label govuk-checkboxes__label" for="ouroboros_mio">
                  Mio
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input type="checkbox" name="ouroboros[]" id="ouroboros_eunie" value="eunie" class="govuk-checkboxes__input">
                <label class="govuk-label govuk-checkboxes__label" for="ouroboros_eunie">
                  Eunie
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input type="checkbox" name="ouroboros[]" id="ouroboros_taion" value="taion" class="govuk-checkboxes__input">
                <label class="govuk-label govuk-checkboxes__label" for="ouroboros_taion">
                  Taion
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input type="checkbox" name="ouroboros[]" id="ouroboros_lanz" value="lanz" class="govuk-checkboxes__input">
                <label class="govuk-label govuk-checkboxes__label" for="ouroboros_lanz">
                  Lanz
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input type="checkbox" name="ouroboros[]" id="ouroboros_sena" value="sena" class="govuk-checkboxes__input">
                <label class="govuk-label govuk-checkboxes__label" for="ouroboros_sena">
                  Sena
                </label>
              </div>
            </div>
          </fieldset>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with checkboxes in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:result) { govuk_checkboxes(attribute, checkbox_items, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with checkboxes in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    # rubocop:disable RSpec/MultipleExpectations
    context 'when additional classes are passed' do
      let(:form_group_options) { { classes: 'my-custom-form-group-class' } }
      let(:fieldset_options) { { classes: 'my-custom-fieldset-class' } }
      let(:legend_options) { { classes: 'my-custom-legend-class' } }
      let(:checkboxes_options) { { classes: 'my-custom-checkboxes-class' } }

      it 'has the custom classes' do
        expect(form_group_element[:class]).to eq('govuk-form-group my-custom-form-group-class')
        expect(fieldset_element[:class]).to eq('govuk-fieldset my-custom-fieldset-class')
        expect(legend_element[:class]).to eq('govuk-fieldset__legend my-custom-legend-class')
        expect(checkboxes_element[:class]).to eq('govuk-checkboxes my-custom-checkboxes-class')
      end
    end
    # rubocop:enable RSpec/MultipleExpectations

    context 'when additional ids are passed' do
      let(:form_group_options) { { attributes: { id: 'my-custom-form-group-id' } } }
      let(:fieldset_options) { { attributes: { id: 'my-custom-fieldset-id' } } }
      let(:checkboxes_options) { { attributes: { id: 'my-custom-checkboxes-id' } } }

      it 'has the custom ids' do
        expect(form_group_element[:id]).to eq('my-custom-form-group-id')
        expect(fieldset_element[:id]).to eq('my-custom-fieldset-id')
        expect(checkboxes_element[:id]).to eq('my-custom-checkboxes-id')
      end
    end

    context 'when one of the items is checked' do
      let(:checkbox_items) do
        [
          {
            value: 'noah',
            label: {
              text: 'Noah'
            }
          },
          {
            value: 'eunie',
            label: {
              text: 'Eunie'
            },
            checked: true
          },
          {
            value: 'lanz',
            label: {
              text: 'Lanz'
            }
          }
        ]
      end

      it 'checks the right option' do
        expect(checkbox_item_elements[0].find('input')).not_to be_checked
        expect(checkbox_item_elements[1].find('input')).to be_checked
        expect(checkbox_item_elements[2].find('input')).not_to be_checked
      end
    end

    context 'when considering attributes in a checkbox item' do
      context 'and we consider the checkbox item input' do
        context 'and it has an irregular value' do
          let(:checkbox_items) do
            [
              {
                value: 'Zeke Von Gembu, Bringer of Chaos',
                label: {
                  text: 'Zeke'
                }
              }
            ]
          end

          it 'is able to format an ID' do
            expect(checkbox_item_elements[0].find('input')[:id]).to eq('ouroboros_Zeke_Von_Gembu__Bringer_of_Chaos')
            expect(checkbox_item_elements[0].find('label')[:for]).to eq('ouroboros_Zeke_Von_Gembu__Bringer_of_Chaos')
          end
        end

        context 'and it has a custom ID' do
          let(:checkbox_items) do
            [
              {
                value: 'noah',
                label: {
                  text: 'Noah'
                },
                attributes: {
                  id: 'my-custom-checkbox-item-id'
                }
              }
            ]
          end

          it 'is overwrites the ID of the checkbox item' do
            expect(checkbox_item_elements[0].find('input')[:id]).to eq('my-custom-checkbox-item-id')
            expect(checkbox_item_elements[0].find('label')[:for]).to eq('my-custom-checkbox-item-id')
          end
        end

        context 'and it has a custom name' do
          let(:checkbox_items) do
            [
              {
                value: 'noah',
                label: {
                  text: 'Noah'
                },
                attributes: {
                  name: 'my-custom-checkbox-item-name'
                }
              }
            ]
          end

          it 'overwrites the ID of the checkbox item' do
            expect(checkbox_item_elements[0].find('input')[:name]).to eq('my-custom-checkbox-item-name')
          end
        end
      end

      context 'and we consider the checkbox item label' do
        context 'and it has custom classes' do
          let(:checkbox_items) do
            [
              {
                value: 'noah',
                label: {
                  text: 'Noah',
                  classes: 'my-custom-label-class'
                }
              }
            ]
          end

          it 'adds to the class of the checkbox item label' do
            expect(checkbox_item_elements[0].find('label')[:class]).to eq('govuk-label govuk-checkboxes__label my-custom-label-class')
          end
        end

        context 'when the checkbox item label has custom attributes' do
          let(:checkbox_items) do
            [
              {
                value: 'noah',
                label: {
                  text: 'Noah',
                  attributes: {
                    id: 'my-custom-label-id',
                    data: {
                      test: 'custom-data-attribute'
                    }
                  }
                }
              }
            ]
          end

          it 'has the custom attributes on the label' do
            expect(checkbox_item_elements[0].find('label')[:id]).to eq('my-custom-label-id')
            expect(checkbox_item_elements[0].find('label')[:'data-test']).to eq('custom-data-attribute')
          end
        end
      end

      context 'when the checkbox item has a hint' do
        let(:checkbox_items) do
          [
            {
              value: 'eunie',
              label: {
                text: 'Eunie'
              },
              hint: {
                text: 'Come on, who else?'
              }
            },
            {
              value: 'sena',
              label: {
                text: 'Sena'
              },
              hint: {
                text: "I'm the girl with the gall!"
              }
            }
          ]
        end

        it 'renders the checkbox items with the hint' do
          expect(checkboxes_element.to_html).to eq('
            <div class="govuk-checkboxes" data-module="govuk-checkboxes">
              <div class="govuk-checkboxes__item">
                <input type="checkbox" name="ouroboros[]" id="ouroboros_eunie" value="eunie" class="govuk-checkboxes__input" aria-describedby="ouroboros_eunie-item-hint">
                <label class="govuk-label govuk-checkboxes__label" for="ouroboros_eunie">
                  Eunie
                </label>
                <div id="ouroboros_eunie-item-hint" class="govuk-hint govuk-checkboxes__hint">
                  Come on, who else?
                </div>
              </div>
              <div class="govuk-checkboxes__item">
                <input type="checkbox" name="ouroboros[]" id="ouroboros_sena" value="sena" class="govuk-checkboxes__input" aria-describedby="ouroboros_sena-item-hint">
                <label class="govuk-label govuk-checkboxes__label" for="ouroboros_sena">
                  Sena
                </label>
                <div id="ouroboros_sena-item-hint" class="govuk-hint govuk-checkboxes__hint">
                  I\'m the girl with the gall!
                </div>
              </div>
            </div>
          '.to_one_line)
        end

        context 'and the hint has custom ID' do
          let(:checkbox_items) do
            [
              {
                value: 'eunie',
                label: {
                  text: 'Eunie'
                },
                hint: {
                  text: 'Come on, who else?',
                  attributes: {
                    id: 'custom-checkbox-item-hint-id'
                  }
                }
              }
            ]
          end

          it 'renders the checkbox items with the custom hint ID' do
            expect(checkbox_item_elements[0].find('input')[:'aria-describedby']).to eq('custom-checkbox-item-hint-id')
            expect(checkbox_item_elements[0].find('div.govuk-hint')[:id]).to eq('custom-checkbox-item-hint-id')
          end
        end
      end
    end

    context 'when there is a divider' do
      let(:checkbox_items) do
        [
          {
            value: 'noah',
            label: {
              text: 'Noah'
            }
          },
          {
            value: 'lanz',
            label: {
              text: 'Lanz'
            }
          },
          {
            divider: 'or'
          },
          {
            value: 'eunie',
            label: {
              text: 'Eunie'
            }
          }
        ]
      end

      it 'renders the checkbox divider amongst the items' do
        expect(checkboxes_element.to_html).to eq('
          <div class="govuk-checkboxes" data-module="govuk-checkboxes">
            <div class="govuk-checkboxes__item">
              <input type="checkbox" name="ouroboros[]" id="ouroboros_noah" value="noah" class="govuk-checkboxes__input">
              <label class="govuk-label govuk-checkboxes__label" for="ouroboros_noah">
                Noah
              </label>
            </div>
            <div class="govuk-checkboxes__item">
              <input type="checkbox" name="ouroboros[]" id="ouroboros_lanz" value="lanz" class="govuk-checkboxes__input">
              <label class="govuk-label govuk-checkboxes__label" for="ouroboros_lanz">
                Lanz
              </label>
            </div>
            <div class="govuk-checkboxes__divider">
              or
            </div>
            <div class="govuk-checkboxes__item">
              <input type="checkbox" name="ouroboros[]" id="ouroboros_eunie" value="eunie" class="govuk-checkboxes__input">
              <label class="govuk-label govuk-checkboxes__label" for="ouroboros_eunie">
                Eunie
              </label>
            </div>
          </div>
        '.to_one_line)
      end
    end

    context 'when there is a hint' do
      let(:options) { options_with_hint }
      let(:checkbox_items) { single_checkbox_item }

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the hint' do
          expect(form_group_element.to_html).to eq('
            <div class="govuk-form-group" id="ouroboros-form-group">
              <fieldset aria-describedby="ouroboros-hint" class="govuk-fieldset">
                <legend class="govuk-fieldset__legend">
                  Select your favourite characters
                </legend>
                <div id="ouroboros-hint" class="govuk-hint">
                  Pick at least one option from the list
                </div>
                <div class="govuk-checkboxes" data-module="govuk-checkboxes">
                  <div class="govuk-checkboxes__item">
                    <input type="checkbox" name="ouroboros[]" id="ouroboros_eunie" value="eunie" class="govuk-checkboxes__input">
                    <label class="govuk-label govuk-checkboxes__label" for="ouroboros_eunie">
                      Eunie
                    </label>
                  </div>
                </div>
              </fieldset>
            </div>
          '.to_one_line)
        end
      end

      context 'when additional classes are passed' do
        let(:hint_options) { { classes: 'my-custom-hint-class' } }

        it 'has the custom classes for the hint' do
          expect(hint_element[:class]).to eq('govuk-hint my-custom-hint-class')
        end
      end

      context 'when additional ids are passed' do
        let(:hint_options) { { attributes: { id: 'my-custom-hint-id' } } }

        it 'has the custom id for the hint and the fieldset has it in its area describedby' do
          expect(hint_element[:id]).to eq('my-custom-hint-id')
          expect(fieldset_element[:'aria-describedby']).to eq('my-custom-hint-id')
        end
      end

      context 'when aria-describedby attribute for the fieldset is passed' do
        let(:fieldset_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the fieldset aria described by as the custom and hint id' do
          expect(fieldset_element[:'aria-describedby']).to eq('some-id ouroboros-hint')
        end
      end
    end

    context 'when there is an error message' do
      let(:error_message) { 'You must choose your favourite characters' }
      let(:checkbox_items) { single_checkbox_item }

      it 'correctly formats the HTML with error message and classes' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <fieldset aria-describedby="ouroboros-error" class="govuk-fieldset">
              <legend class="govuk-fieldset__legend">
                Select your favourite characters
              </legend>
              <p class="govuk-error-message" id="ouroboros-error">
                <span class="govuk-visually-hidden">Error: </span>
                You must choose your favourite characters
              </p>
              <div class="govuk-checkboxes" data-module="govuk-checkboxes">
                <div class="govuk-checkboxes__item">
                  <input type="checkbox" name="ouroboros[]" id="ouroboros_eunie" value="eunie" class="govuk-checkboxes__input">
                  <label class="govuk-label govuk-checkboxes__label" for="ouroboros_eunie">
                    Eunie
                  </label>
                </div>
              </div>
            </fieldset>
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the fieldset is passed' do
        let(:fieldset_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the fieldset aria described by as the custom and error id' do
          expect(fieldset_element[:'aria-describedby']).to eq('some-id ouroboros-error')
        end
      end
    end

    context 'when there is a hint and an error message' do
      let(:error_message) { 'You must choose your favourite characters' }
      let(:options) { options_with_hint }
      let(:checkbox_items) { single_checkbox_item }

      it 'correctly formats the HTML with error message and the hint with the aria-describedby from the hint then error message' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <fieldset aria-describedby="ouroboros-hint ouroboros-error" class="govuk-fieldset">
              <legend class="govuk-fieldset__legend">
                Select your favourite characters
              </legend>
              <div id="ouroboros-hint" class="govuk-hint">
                Pick at least one option from the list
              </div>
              <p class="govuk-error-message" id="ouroboros-error">
                <span class="govuk-visually-hidden">Error: </span>
                You must choose your favourite characters
              </p>
              <div class="govuk-checkboxes" data-module="govuk-checkboxes">
                <div class="govuk-checkboxes__item">
                  <input type="checkbox" name="ouroboros[]" id="ouroboros_eunie" value="eunie" class="govuk-checkboxes__input">
                  <label class="govuk-label govuk-checkboxes__label" for="ouroboros_eunie">
                    Eunie
                  </label>
                </div>
              </div>
            </fieldset>
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the fieldset is passed' do
        let(:fieldset_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the fieldset aria described by as the custom, hint and error id' do
          expect(fieldset_element[:'aria-describedby']).to eq('some-id ouroboros-hint ouroboros-error')
        end
      end
    end

    context 'when there is conditional content within the item' do
      let(:checkbox_items) { conditional_checkbox_item }

      it 'correctly formats the HTML with the conditional item' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group" id="ouroboros-form-group">
            <fieldset class="govuk-fieldset">
              <legend class="govuk-fieldset__legend">
                Select your favourite characters
              </legend>
              <div class="govuk-checkboxes" data-module="govuk-checkboxes">
                <div class="govuk-checkboxes__item">
                  <input type="checkbox" name="ouroboros[]" id="ouroboros_eunie" value="eunie" class="govuk-checkboxes__input" data-aria-controls="ouroboros_eunie_conditional">
                  <label class="govuk-label govuk-checkboxes__label" for="ouroboros_eunie">
                    Eunie
                  </label>
                  <div class="govuk-checkboxes__conditional govuk-checkboxes__conditional--hidden" id="ouroboros_eunie_conditional">
                    Hello there!
                  </div>
                </div>
              </div>
            </fieldset>
          </div>
        '.to_one_line)
      end

      context 'when the item is checked' do
        before { conditional_checkbox_item[0][:checked] = true }

        it 'does not hide the conditional content' do
          expect(checkbox_item_elements[0].find_by_id('ouroboros_eunie_conditional')[:class]).to eq('govuk-checkboxes__conditional')
        end
      end

      context 'when a custom ID is passed' do
        before { conditional_checkbox_item[0][:conditional][:attributes] = { id: 'my-custom-conditional-id' } }

        it 'has the custom id' do
          expect(checkbox_item_elements[0].find('input')[:'data-aria-controls']).to eq('my-custom-conditional-id')
          expect(checkbox_item_elements[0].find('div')[:id]).to eq('my-custom-conditional-id')
        end
      end

      context 'when there are other data attributes' do
        before { conditional_checkbox_item[0][:attributes] = { data: { test: 'data-test' } } }

        it 'has the correct attributes' do
          expect(checkbox_item_elements[0].find('input')[:'data-test']).to eq('data-test')
          expect(checkbox_item_elements[0].find('input')[:'data-aria-controls']).to eq('ouroboros_eunie_conditional')
        end
      end
    end
  end

  describe '.govuk_checkboxes with model' do
    let(:result) { govuk_checkboxes(attribute, checkbox_items, model: model, **options) }

    let(:default_html) do
      '
        <div class="govuk-form-group" id="ouroboros-form-group">
          <fieldset class="govuk-fieldset">
            <legend class="govuk-fieldset__legend">
              Select your favourite characters
            </legend>
            <div class="govuk-checkboxes" data-module="govuk-checkboxes">
              <div class="govuk-checkboxes__item">
                <input type="checkbox" name="ouroboros[]" id="ouroboros_noah" value="noah" class="govuk-checkboxes__input">
                <label class="govuk-label govuk-checkboxes__label" for="ouroboros_noah">
                  Noah
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input type="checkbox" name="ouroboros[]" id="ouroboros_mio" value="mio" class="govuk-checkboxes__input">
                <label class="govuk-label govuk-checkboxes__label" for="ouroboros_mio">
                  Mio
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input type="checkbox" name="ouroboros[]" id="ouroboros_eunie" value="eunie" class="govuk-checkboxes__input">
                <label class="govuk-label govuk-checkboxes__label" for="ouroboros_eunie">
                  Eunie
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input type="checkbox" name="ouroboros[]" id="ouroboros_taion" value="taion" class="govuk-checkboxes__input">
                <label class="govuk-label govuk-checkboxes__label" for="ouroboros_taion">
                  Taion
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input type="checkbox" name="ouroboros[]" id="ouroboros_lanz" value="lanz" class="govuk-checkboxes__input">
                <label class="govuk-label govuk-checkboxes__label" for="ouroboros_lanz">
                  Lanz
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input type="checkbox" name="ouroboros[]" id="ouroboros_sena" value="sena" class="govuk-checkboxes__input">
                <label class="govuk-label govuk-checkboxes__label" for="ouroboros_sena">
                  Sena
                </label>
              </div>
            </div>
          </fieldset>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with checkboxes in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:result) { govuk_checkboxes(attribute, checkbox_items, model: model, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with checkboxes in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    # rubocop:disable RSpec/MultipleExpectations
    context 'when additional classes are passed' do
      let(:form_group_options) { { classes: 'my-custom-form-group-class' } }
      let(:fieldset_options) { { classes: 'my-custom-fieldset-class' } }
      let(:legend_options) { { classes: 'my-custom-legend-class' } }
      let(:checkboxes_options) { { classes: 'my-custom-checkboxes-class' } }

      it 'has the custom classes' do
        expect(form_group_element[:class]).to eq('govuk-form-group my-custom-form-group-class')
        expect(fieldset_element[:class]).to eq('govuk-fieldset my-custom-fieldset-class')
        expect(legend_element[:class]).to eq('govuk-fieldset__legend my-custom-legend-class')
        expect(checkboxes_element[:class]).to eq('govuk-checkboxes my-custom-checkboxes-class')
      end
    end
    # rubocop:enable RSpec/MultipleExpectations

    context 'when additional ids are passed' do
      let(:form_group_options) { { attributes: { id: 'my-custom-form-group-id' } } }
      let(:fieldset_options) { { attributes: { id: 'my-custom-fieldset-id' } } }
      let(:checkboxes_options) { { attributes: { id: 'my-custom-checkboxes-id' } } }

      it 'has the custom ids' do
        expect(form_group_element[:id]).to eq('my-custom-form-group-id')
        expect(fieldset_element[:id]).to eq('my-custom-fieldset-id')
        expect(checkboxes_element[:id]).to eq('my-custom-checkboxes-id')
      end
    end

    context 'when some of the items is checked' do
      before { model.ouroboros = ['mio', 'eunie'] }

      it 'checks the right options' do
        expect(checkbox_item_elements.count { |element| element.find('input').checked? }).to eq 2
        expect(checkbox_item_elements[1].find('input')).to be_checked
        expect(checkbox_item_elements[2].find('input')).to be_checked
      end
    end

    context 'when considering attributes in a checkbox item' do
      context 'and we consider the checkbox item input' do
        context 'and it has an irregular value' do
          let(:checkbox_items) do
            [
              {
                value: 'Zeke Von Gembu, Bringer of Chaos',
                label: {
                  text: 'Zeke'
                }
              }
            ]
          end

          it 'is able to format an ID' do
            expect(checkbox_item_elements[0].find('input')[:id]).to eq('ouroboros_Zeke_Von_Gembu__Bringer_of_Chaos')
            expect(checkbox_item_elements[0].find('label')[:for]).to eq('ouroboros_Zeke_Von_Gembu__Bringer_of_Chaos')
          end
        end

        context 'and it has a custom ID' do
          let(:checkbox_items) do
            [
              {
                value: 'noah',
                label: {
                  text: 'Noah'
                },
                attributes: {
                  id: 'my-custom-checkbox-item-id'
                }
              }
            ]
          end

          it 'is overwrites the ID of the checkbox item' do
            expect(checkbox_item_elements[0].find('input')[:id]).to eq('my-custom-checkbox-item-id')
            expect(checkbox_item_elements[0].find('label')[:for]).to eq('my-custom-checkbox-item-id')
          end
        end

        context 'and it has a custom name' do
          let(:checkbox_items) do
            [
              {
                value: 'noah',
                label: {
                  text: 'Noah'
                },
                attributes: {
                  name: 'my-custom-checkbox-item-name'
                }
              }
            ]
          end

          it 'overwrites the ID of the checkbox item' do
            expect(checkbox_item_elements[0].find('input')[:name]).to eq('my-custom-checkbox-item-name')
          end
        end
      end

      context 'and we consider the checkbox item label' do
        context 'and it has custom classes' do
          let(:checkbox_items) do
            [
              {
                value: 'noah',
                label: {
                  text: 'Noah',
                  classes: 'my-custom-label-class'
                }
              }
            ]
          end

          it 'adds to the class of the checkbox item label' do
            expect(checkbox_item_elements[0].find('label')[:class]).to eq('govuk-label govuk-checkboxes__label my-custom-label-class')
          end
        end

        context 'when the checkbox item label has custom attributes' do
          let(:checkbox_items) do
            [
              {
                value: 'noah',
                label: {
                  text: 'Noah',
                  attributes: {
                    id: 'my-custom-label-id',
                    data: {
                      test: 'custom-data-attribute'
                    }
                  }
                }
              }
            ]
          end

          it 'has the custom attributes on the label' do
            expect(checkbox_item_elements[0].find('label')[:id]).to eq('my-custom-label-id')
            expect(checkbox_item_elements[0].find('label')[:'data-test']).to eq('custom-data-attribute')
          end
        end
      end

      context 'when the checkbox item has a hint' do
        let(:checkbox_items) do
          [
            {
              value: 'eunie',
              label: {
                text: 'Eunie'
              },
              hint: {
                text: 'Come on, who else?'
              }
            },
            {
              value: 'sena',
              label: {
                text: 'Sena'
              },
              hint: {
                text: "I'm the girl with the gall!"
              }
            }
          ]
        end

        it 'renders the checkbox items with the hint' do
          expect(checkboxes_element.to_html).to eq('
            <div class="govuk-checkboxes" data-module="govuk-checkboxes">
              <div class="govuk-checkboxes__item">
                <input type="checkbox" name="ouroboros[]" id="ouroboros_eunie" value="eunie" class="govuk-checkboxes__input" aria-describedby="ouroboros_eunie-item-hint">
                <label class="govuk-label govuk-checkboxes__label" for="ouroboros_eunie">
                  Eunie
                </label>
                <div id="ouroboros_eunie-item-hint" class="govuk-hint govuk-checkboxes__hint">
                  Come on, who else?
                </div>
              </div>
              <div class="govuk-checkboxes__item">
                <input type="checkbox" name="ouroboros[]" id="ouroboros_sena" value="sena" class="govuk-checkboxes__input" aria-describedby="ouroboros_sena-item-hint">
                <label class="govuk-label govuk-checkboxes__label" for="ouroboros_sena">
                  Sena
                </label>
                <div id="ouroboros_sena-item-hint" class="govuk-hint govuk-checkboxes__hint">
                  I\'m the girl with the gall!
                </div>
              </div>
            </div>
          '.to_one_line)
        end

        context 'and the hint has custom ID' do
          let(:checkbox_items) do
            [
              {
                value: 'eunie',
                label: {
                  text: 'Eunie'
                },
                hint: {
                  text: 'Come on, who else?',
                  attributes: {
                    id: 'custom-checkbox-item-hint-id'
                  }
                }
              }
            ]
          end

          it 'renders the checkbox items with the custom hint ID' do
            expect(checkbox_item_elements[0].find('input')[:'aria-describedby']).to eq('custom-checkbox-item-hint-id')
            expect(checkbox_item_elements[0].find('div.govuk-hint')[:id]).to eq('custom-checkbox-item-hint-id')
          end
        end
      end
    end

    context 'when there is a divider' do
      let(:checkbox_items) do
        [
          {
            value: 'noah',
            label: {
              text: 'Noah'
            }
          },
          {
            value: 'lanz',
            label: {
              text: 'Lanz'
            }
          },
          {
            divider: 'or'
          },
          {
            value: 'eunie',
            label: {
              text: 'Eunie'
            }
          }
        ]
      end

      it 'renders the checkbox divider amongst the items' do
        expect(checkboxes_element.to_html).to eq('
          <div class="govuk-checkboxes" data-module="govuk-checkboxes">
            <div class="govuk-checkboxes__item">
              <input type="checkbox" name="ouroboros[]" id="ouroboros_noah" value="noah" class="govuk-checkboxes__input">
              <label class="govuk-label govuk-checkboxes__label" for="ouroboros_noah">
                Noah
              </label>
            </div>
            <div class="govuk-checkboxes__item">
              <input type="checkbox" name="ouroboros[]" id="ouroboros_lanz" value="lanz" class="govuk-checkboxes__input">
              <label class="govuk-label govuk-checkboxes__label" for="ouroboros_lanz">
                Lanz
              </label>
            </div>
            <div class="govuk-checkboxes__divider">
              or
            </div>
            <div class="govuk-checkboxes__item">
              <input type="checkbox" name="ouroboros[]" id="ouroboros_eunie" value="eunie" class="govuk-checkboxes__input">
              <label class="govuk-label govuk-checkboxes__label" for="ouroboros_eunie">
                Eunie
              </label>
            </div>
          </div>
        '.to_one_line)
      end
    end

    context 'when there is a hint' do
      let(:options) { options_with_hint }
      let(:checkbox_items) { single_checkbox_item }

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the hint' do
          expect(form_group_element.to_html).to eq('
            <div class="govuk-form-group" id="ouroboros-form-group">
              <fieldset aria-describedby="ouroboros-hint" class="govuk-fieldset">
                <legend class="govuk-fieldset__legend">
                  Select your favourite characters
                </legend>
                <div id="ouroboros-hint" class="govuk-hint">
                  Pick at least one option from the list
                </div>
                <div class="govuk-checkboxes" data-module="govuk-checkboxes">
                  <div class="govuk-checkboxes__item">
                    <input type="checkbox" name="ouroboros[]" id="ouroboros_eunie" value="eunie" class="govuk-checkboxes__input">
                    <label class="govuk-label govuk-checkboxes__label" for="ouroboros_eunie">
                      Eunie
                    </label>
                  </div>
                </div>
              </fieldset>
            </div>
          '.to_one_line)
        end
      end

      context 'when additional classes are passed' do
        let(:hint_options) { { classes: 'my-custom-hint-class' } }

        it 'has the custom classes for the hint' do
          expect(hint_element[:class]).to eq('govuk-hint my-custom-hint-class')
        end
      end

      context 'when additional ids are passed' do
        let(:hint_options) { { attributes: { id: 'my-custom-hint-id' } } }

        it 'has the custom id for the hint and the fieldset has it in its area describedby' do
          expect(hint_element[:id]).to eq('my-custom-hint-id')
          expect(fieldset_element[:'aria-describedby']).to eq('my-custom-hint-id')
        end
      end

      context 'when aria-describedby attribute for the fieldset is passed' do
        let(:fieldset_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the fieldset aria described by as the custom and hint id' do
          expect(fieldset_element[:'aria-describedby']).to eq('some-id ouroboros-hint')
        end
      end
    end

    context 'when there is an error message' do
      let(:checkbox_items) { single_checkbox_item }

      before { model.errors.add(:ouroboros, message: 'You must choose your favourite characters') }

      it 'correctly formats the HTML with error message and classes' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <fieldset aria-describedby="ouroboros-error" class="govuk-fieldset">
              <legend class="govuk-fieldset__legend">
                Select your favourite characters
              </legend>
              <p class="govuk-error-message" id="ouroboros-error">
                <span class="govuk-visually-hidden">Error: </span>
                You must choose your favourite characters
              </p>
              <div class="govuk-checkboxes" data-module="govuk-checkboxes">
                <div class="govuk-checkboxes__item">
                  <input type="checkbox" name="ouroboros[]" id="ouroboros_eunie" value="eunie" class="govuk-checkboxes__input">
                  <label class="govuk-label govuk-checkboxes__label" for="ouroboros_eunie">
                    Eunie
                  </label>
                </div>
              </div>
            </fieldset>
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the fieldset is passed' do
        let(:fieldset_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the fieldset aria described by as the custom and error id' do
          expect(fieldset_element[:'aria-describedby']).to eq('some-id ouroboros-error')
        end
      end
    end

    context 'when there is a hint and an error message' do
      let(:options) { options_with_hint }
      let(:checkbox_items) { single_checkbox_item }

      before { model.errors.add(:ouroboros, message: 'You must choose your favourite characters') }

      it 'correctly formats the HTML with error message and the hint with the aria-describedby from the hint then error message' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <fieldset aria-describedby="ouroboros-hint ouroboros-error" class="govuk-fieldset">
              <legend class="govuk-fieldset__legend">
                Select your favourite characters
              </legend>
              <div id="ouroboros-hint" class="govuk-hint">
                Pick at least one option from the list
              </div>
              <p class="govuk-error-message" id="ouroboros-error">
                <span class="govuk-visually-hidden">Error: </span>
                You must choose your favourite characters
              </p>
              <div class="govuk-checkboxes" data-module="govuk-checkboxes">
                <div class="govuk-checkboxes__item">
                  <input type="checkbox" name="ouroboros[]" id="ouroboros_eunie" value="eunie" class="govuk-checkboxes__input">
                  <label class="govuk-label govuk-checkboxes__label" for="ouroboros_eunie">
                    Eunie
                  </label>
                </div>
              </div>
            </fieldset>
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the fieldset is passed' do
        let(:fieldset_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the fieldset aria described by as the custom, hint and error id' do
          expect(fieldset_element[:'aria-describedby']).to eq('some-id ouroboros-hint ouroboros-error')
        end
      end
    end

    context 'when there is conditional content within the item' do
      let(:checkbox_items) { conditional_checkbox_item }

      it 'correctly formats the HTML with the conditional item' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group" id="ouroboros-form-group">
            <fieldset class="govuk-fieldset">
              <legend class="govuk-fieldset__legend">
                Select your favourite characters
              </legend>
              <div class="govuk-checkboxes" data-module="govuk-checkboxes">
                <div class="govuk-checkboxes__item">
                  <input type="checkbox" name="ouroboros[]" id="ouroboros_eunie" value="eunie" class="govuk-checkboxes__input" data-aria-controls="ouroboros_eunie_conditional">
                  <label class="govuk-label govuk-checkboxes__label" for="ouroboros_eunie">
                    Eunie
                  </label>
                  <div class="govuk-checkboxes__conditional govuk-checkboxes__conditional--hidden" id="ouroboros_eunie_conditional">
                    Hello there!
                  </div>
                </div>
              </div>
            </fieldset>
          </div>
        '.to_one_line)
      end

      context 'when the item is checked' do
        before { model.ouroboros = 'eunie' }

        it 'does not hide the conditional content' do
          expect(checkbox_item_elements[0].find_by_id('ouroboros_eunie_conditional')[:class]).to eq('govuk-checkboxes__conditional')
        end
      end

      context 'when a custom ID is passed' do
        before { conditional_checkbox_item[0][:conditional][:attributes] = { id: 'my-custom-conditional-id' } }

        it 'has the custom id' do
          expect(checkbox_item_elements[0].find('input')[:'data-aria-controls']).to eq('my-custom-conditional-id')
          expect(checkbox_item_elements[0].find('div')[:id]).to eq('my-custom-conditional-id')
        end
      end

      context 'when there are other data attributes' do
        before { conditional_checkbox_item[0][:attributes] = { data: { test: 'data-test' } } }

        it 'has the correct attributes' do
          expect(checkbox_item_elements[0].find('input')[:'data-test']).to eq('data-test')
          expect(checkbox_item_elements[0].find('input')[:'data-aria-controls']).to eq('ouroboros_eunie_conditional')
        end
      end
    end
  end

  describe '.govuk_checkboxes with form' do
    let(:result) { govuk_checkboxes(attribute, checkbox_items, form: form, **options) }
    let(:form) do
      ActionView::Helpers::FormBuilder.new(
        TestModel.model_name.singular,
        model,
        TestView.new(:lookup_context, [], :controller),
        {}
      )
    end

    let(:default_html) do
      '
        <div class="govuk-form-group" id="ouroboros-form-group">
          <fieldset class="govuk-fieldset">
            <legend class="govuk-fieldset__legend">
              Select your favourite characters
            </legend>
            <div class="govuk-checkboxes" data-module="govuk-checkboxes">
              <div class="govuk-checkboxes__item">
                <input class="govuk-checkboxes__input" type="checkbox" value="noah" name="test_model[ouroboros][]" id="test_model_ouroboros_noah">
                <label class="govuk-label govuk-checkboxes__label" for="test_model_ouroboros_noah">
                  Noah
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input class="govuk-checkboxes__input" type="checkbox" value="mio" name="test_model[ouroboros][]" id="test_model_ouroboros_mio">
                <label class="govuk-label govuk-checkboxes__label" for="test_model_ouroboros_mio">
                  Mio
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input class="govuk-checkboxes__input" type="checkbox" value="eunie" name="test_model[ouroboros][]" id="test_model_ouroboros_eunie">
                <label class="govuk-label govuk-checkboxes__label" for="test_model_ouroboros_eunie">
                  Eunie
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input class="govuk-checkboxes__input" type="checkbox" value="taion" name="test_model[ouroboros][]" id="test_model_ouroboros_taion">
                <label class="govuk-label govuk-checkboxes__label" for="test_model_ouroboros_taion">
                  Taion
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input class="govuk-checkboxes__input" type="checkbox" value="lanz" name="test_model[ouroboros][]" id="test_model_ouroboros_lanz">
                <label class="govuk-label govuk-checkboxes__label" for="test_model_ouroboros_lanz">
                  Lanz
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input class="govuk-checkboxes__input" type="checkbox" value="sena" name="test_model[ouroboros][]" id="test_model_ouroboros_sena">
                <label class="govuk-label govuk-checkboxes__label" for="test_model_ouroboros_sena">
                  Sena
                </label>
              </div>
            </div>
          </fieldset>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with checkboxes in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:result) { govuk_checkboxes(attribute, checkbox_items, form: form, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with checkboxes in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    # rubocop:disable RSpec/MultipleExpectations
    context 'when additional classes are passed' do
      let(:form_group_options) { { classes: 'my-custom-form-group-class' } }
      let(:fieldset_options) { { classes: 'my-custom-fieldset-class' } }
      let(:legend_options) { { classes: 'my-custom-legend-class' } }
      let(:checkboxes_options) { { classes: 'my-custom-checkboxes-class' } }

      it 'has the custom classes' do
        expect(form_group_element[:class]).to eq('govuk-form-group my-custom-form-group-class')
        expect(fieldset_element[:class]).to eq('govuk-fieldset my-custom-fieldset-class')
        expect(legend_element[:class]).to eq('govuk-fieldset__legend my-custom-legend-class')
        expect(checkboxes_element[:class]).to eq('govuk-checkboxes my-custom-checkboxes-class')
      end
    end
    # rubocop:enable RSpec/MultipleExpectations

    context 'when additional ids are passed' do
      let(:form_group_options) { { attributes: { id: 'my-custom-form-group-id' } } }
      let(:fieldset_options) { { attributes: { id: 'my-custom-fieldset-id' } } }
      let(:checkboxes_options) { { attributes: { id: 'my-custom-checkboxes-id' } } }

      it 'has the custom ids' do
        expect(form_group_element[:id]).to eq('my-custom-form-group-id')
        expect(fieldset_element[:id]).to eq('my-custom-fieldset-id')
        expect(checkboxes_element[:id]).to eq('my-custom-checkboxes-id')
      end
    end

    context 'when some of the items is checked' do
      before { model.ouroboros = ['mio', 'eunie'] }

      it 'checks the right options' do
        expect(checkbox_item_elements.count { |element| element.find('input').checked? }).to eq 2
        expect(checkbox_item_elements[1].find('input')).to be_checked
        expect(checkbox_item_elements[2].find('input')).to be_checked
      end
    end

    context 'when considering attributes in a checkbox item' do
      context 'and we consider the checkbox item input' do
        context 'and it has an irregular value' do
          let(:checkbox_items) do
            [
              {
                value: 'Zeke Von Gembu, Bringer of Chaos',
                label: {
                  text: 'Zeke'
                }
              }
            ]
          end

          it 'is able to format an ID' do
            expect(checkbox_item_elements[0].find('input')[:id]).to eq('test_model_ouroboros_zeke_von_gembu_bringer_of_chaos')
            expect(checkbox_item_elements[0].find('label')[:for]).to eq('test_model_ouroboros_zeke_von_gembu_bringer_of_chaos')
          end
        end

        context 'and it has a custom ID' do
          let(:checkbox_items) do
            [
              {
                value: 'noah',
                label: {
                  text: 'Noah'
                },
                attributes: {
                  id: 'my-custom-checkbox-item-id'
                }
              }
            ]
          end

          it 'is ignores the custom id' do
            expect(checkbox_item_elements[0].find('input')[:id]).to eq('my-custom-checkbox-item-id')
            expect(checkbox_item_elements[0].find('label')[:for]).to eq('my-custom-checkbox-item-id')
          end
        end

        context 'and it has a custom name' do
          let(:checkbox_items) do
            [
              {
                value: 'noah',
                label: {
                  text: 'Noah'
                },
                attributes: {
                  name: 'my-custom-checkbox-item-name'
                }
              }
            ]
          end

          it 'overwrites the ID of the checkbox item' do
            expect(checkbox_item_elements[0].find('input')[:name]).to eq('my-custom-checkbox-item-name')
          end
        end
      end

      context 'and we consider the checkbox item label' do
        context 'and it has custom classes' do
          let(:checkbox_items) do
            [
              {
                value: 'noah',
                label: {
                  text: 'Noah',
                  classes: 'my-custom-label-class'
                }
              }
            ]
          end

          it 'adds to the class of the checkbox item label' do
            expect(checkbox_item_elements[0].find('label')[:class]).to eq('govuk-label govuk-checkboxes__label my-custom-label-class')
          end
        end

        context 'when the checkbox item label has custom attributes' do
          let(:checkbox_items) do
            [
              {
                value: 'noah',
                label: {
                  text: 'Noah',
                  attributes: {
                    id: 'my-custom-label-id',
                    data: {
                      test: 'custom-data-attribute'
                    }
                  }
                }
              }
            ]
          end

          it 'has the custom attributes on the label' do
            expect(checkbox_item_elements[0].find('label')[:id]).to eq('my-custom-label-id')
            expect(checkbox_item_elements[0].find('label')[:'data-test']).to eq('custom-data-attribute')
          end
        end
      end

      context 'when the checkbox item has a hint' do
        let(:checkbox_items) do
          [
            {
              value: 'eunie',
              label: {
                text: 'Eunie'
              },
              hint: {
                text: 'Come on, who else?'
              }
            },
            {
              value: 'sena',
              label: {
                text: 'Sena'
              },
              hint: {
                text: "I'm the girl with the gall!"
              }
            }
          ]
        end

        it 'renders the checkbox items with the hint' do
          expect(checkboxes_element.to_html).to eq('
            <div class="govuk-checkboxes" data-module="govuk-checkboxes">
              <div class="govuk-checkboxes__item">
                <input class="govuk-checkboxes__input" aria-describedby="ouroboros_eunie-item-hint" type="checkbox" value="eunie" name="test_model[ouroboros][]" id="test_model_ouroboros_eunie">
                <label class="govuk-label govuk-checkboxes__label" for="test_model_ouroboros_eunie">
                  Eunie
                </label>
                <div id="ouroboros_eunie-item-hint" class="govuk-hint govuk-checkboxes__hint">
                  Come on, who else?
                </div>
              </div>
              <div class="govuk-checkboxes__item">
                <input class="govuk-checkboxes__input" aria-describedby="ouroboros_sena-item-hint" type="checkbox" value="sena" name="test_model[ouroboros][]" id="test_model_ouroboros_sena">
                <label class="govuk-label govuk-checkboxes__label" for="test_model_ouroboros_sena">
                  Sena
                </label>
                <div id="ouroboros_sena-item-hint" class="govuk-hint govuk-checkboxes__hint">
                  I\'m the girl with the gall!
                </div>
              </div>
            </div>
          '.to_one_line)
        end

        context 'and the hint has custom ID' do
          let(:checkbox_items) do
            [
              {
                value: 'eunie',
                label: {
                  text: 'Eunie'
                },
                hint: {
                  text: 'Come on, who else?',
                  attributes: {
                    id: 'custom-checkbox-item-hint-id'
                  }
                }
              }
            ]
          end

          it 'renders the checkbox items with the custom hint ID' do
            expect(checkbox_item_elements[0].find('input')[:'aria-describedby']).to eq('custom-checkbox-item-hint-id')
            expect(checkbox_item_elements[0].find('div.govuk-hint')[:id]).to eq('custom-checkbox-item-hint-id')
          end
        end
      end
    end

    context 'when there is a divider' do
      let(:checkbox_items) do
        [
          {
            value: 'mio',
            label: {
              text: 'Mio'
            }
          },
          {
            value: 'taion',
            label: {
              text: 'Taion'
            }
          },
          {
            divider: 'or'
          },
          {
            value: 'sena',
            label: {
              text: 'Sena'
            }
          }
        ]
      end

      it 'renders the checkbox divider amongst the items' do
        expect(checkboxes_element.to_html).to eq('
          <div class="govuk-checkboxes" data-module="govuk-checkboxes">
            <div class="govuk-checkboxes__item">
              <input class="govuk-checkboxes__input" type="checkbox" value="mio" name="test_model[ouroboros][]" id="test_model_ouroboros_mio">
              <label class="govuk-label govuk-checkboxes__label" for="test_model_ouroboros_mio">
                Mio
              </label>
            </div>
            <div class="govuk-checkboxes__item">
              <input class="govuk-checkboxes__input" type="checkbox" value="taion" name="test_model[ouroboros][]" id="test_model_ouroboros_taion">
              <label class="govuk-label govuk-checkboxes__label" for="test_model_ouroboros_taion">
                Taion
              </label>
            </div>
            <div class="govuk-checkboxes__divider">
              or
            </div>
            <div class="govuk-checkboxes__item">
              <input class="govuk-checkboxes__input" type="checkbox" value="sena" name="test_model[ouroboros][]" id="test_model_ouroboros_sena">
              <label class="govuk-label govuk-checkboxes__label" for="test_model_ouroboros_sena">
                Sena
              </label>
            </div>
          </div>
        '.to_one_line)
      end
    end

    context 'when there is a hint' do
      let(:options) { options_with_hint }
      let(:checkbox_items) { single_checkbox_item }

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the hint' do
          expect(form_group_element.to_html).to eq('
            <div class="govuk-form-group" id="ouroboros-form-group">
              <fieldset aria-describedby="ouroboros-hint" class="govuk-fieldset">
                <legend class="govuk-fieldset__legend">
                  Select your favourite characters
                </legend>
                <div id="ouroboros-hint" class="govuk-hint">
                  Pick at least one option from the list
                </div>
                <div class="govuk-checkboxes" data-module="govuk-checkboxes">
                  <div class="govuk-checkboxes__item">
                    <input class="govuk-checkboxes__input" type="checkbox" value="eunie" name="test_model[ouroboros][]" id="test_model_ouroboros_eunie">
                    <label class="govuk-label govuk-checkboxes__label" for="test_model_ouroboros_eunie">
                      Eunie
                    </label>
                  </div>
                </div>
              </fieldset>
            </div>
          '.to_one_line)
        end
      end

      context 'when additional classes are passed' do
        let(:hint_options) { { classes: 'my-custom-hint-class' } }

        it 'has the custom classes for the hint' do
          expect(hint_element[:class]).to eq('govuk-hint my-custom-hint-class')
        end
      end

      context 'when additional ids are passed' do
        let(:hint_options) { { attributes: { id: 'my-custom-hint-id' } } }

        it 'has the custom id for the hint and the fieldset has it in its area describedby' do
          expect(hint_element[:id]).to eq('my-custom-hint-id')
          expect(fieldset_element[:'aria-describedby']).to eq('my-custom-hint-id')
        end
      end

      context 'when aria-describedby attribute for the fieldset is passed' do
        let(:fieldset_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the fieldset aria described by as the custom and hint id' do
          expect(fieldset_element[:'aria-describedby']).to eq('some-id ouroboros-hint')
        end
      end
    end

    context 'when there is an error message' do
      let(:checkbox_items) { single_checkbox_item }

      before { model.errors.add(:ouroboros, message: 'You must choose your favourite characters') }

      it 'correctly formats the HTML with error message and classes' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <fieldset aria-describedby="ouroboros-error" class="govuk-fieldset">
              <legend class="govuk-fieldset__legend">
                Select your favourite characters
              </legend>
              <p class="govuk-error-message" id="ouroboros-error">
                <span class="govuk-visually-hidden">Error: </span>
                You must choose your favourite characters
              </p>
              <div class="govuk-checkboxes" data-module="govuk-checkboxes">
                <div class="govuk-checkboxes__item">
                  <input class="govuk-checkboxes__input" type="checkbox" value="eunie" name="test_model[ouroboros][]" id="test_model_ouroboros_eunie">
                  <label class="govuk-label govuk-checkboxes__label" for="test_model_ouroboros_eunie">
                    Eunie
                  </label>
                </div>
              </div>
            </fieldset>
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the fieldset is passed' do
        let(:fieldset_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the fieldset aria described by as the custom and error id' do
          expect(fieldset_element[:'aria-describedby']).to eq('some-id ouroboros-error')
        end
      end
    end

    context 'when there is a hint and an error message' do
      let(:options) { options_with_hint }
      let(:checkbox_items) { single_checkbox_item }

      before { model.errors.add(:ouroboros, message: 'You must choose your favourite characters') }

      it 'correctly formats the HTML with error message and the hint with the aria-describedby from the hint then error message' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <fieldset aria-describedby="ouroboros-hint ouroboros-error" class="govuk-fieldset">
              <legend class="govuk-fieldset__legend">
                Select your favourite characters
              </legend>
              <div id="ouroboros-hint" class="govuk-hint">
                Pick at least one option from the list
              </div>
              <p class="govuk-error-message" id="ouroboros-error">
                <span class="govuk-visually-hidden">Error: </span>
                You must choose your favourite characters
              </p>
              <div class="govuk-checkboxes" data-module="govuk-checkboxes">
                <div class="govuk-checkboxes__item">
                  <input class="govuk-checkboxes__input" type="checkbox" value="eunie" name="test_model[ouroboros][]" id="test_model_ouroboros_eunie">
                  <label class="govuk-label govuk-checkboxes__label" for="test_model_ouroboros_eunie">
                    Eunie
                  </label>
                </div>
              </div>
            </fieldset>
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the fieldset is passed' do
        let(:fieldset_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the fieldset aria described by as the custom, hint and error id' do
          expect(fieldset_element[:'aria-describedby']).to eq('some-id ouroboros-hint ouroboros-error')
        end
      end
    end

    context 'when there is conditional content within the item' do
      let(:checkbox_items) { conditional_checkbox_item }

      it 'correctly formats the HTML with the conditional item' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group" id="ouroboros-form-group">
            <fieldset class="govuk-fieldset">
              <legend class="govuk-fieldset__legend">
                Select your favourite characters
              </legend>
              <div class="govuk-checkboxes" data-module="govuk-checkboxes">
                <div class="govuk-checkboxes__item">
                  <input class="govuk-checkboxes__input" data-aria-controls="ouroboros_eunie_conditional" type="checkbox" value="eunie" name="test_model[ouroboros][]" id="test_model_ouroboros_eunie">
                  <label class="govuk-label govuk-checkboxes__label" for="test_model_ouroboros_eunie">
                    Eunie
                  </label>
                  <div class="govuk-checkboxes__conditional govuk-checkboxes__conditional--hidden" id="ouroboros_eunie_conditional">
                    Hello there!
                  </div>
                </div>
              </div>
            </fieldset>
          </div>
        '.to_one_line)
      end

      context 'when the item is checked' do
        before { model.ouroboros = 'eunie' }

        it 'does not hide the conditional content' do
          expect(checkbox_item_elements[0].find_by_id('ouroboros_eunie_conditional')[:class]).to eq('govuk-checkboxes__conditional')
        end
      end

      context 'when a custom ID is passed' do
        before { conditional_checkbox_item[0][:conditional][:attributes] = { id: 'my-custom-conditional-id' } }

        it 'has the custom id' do
          expect(checkbox_item_elements[0].find('input')[:'data-aria-controls']).to eq('my-custom-conditional-id')
          expect(checkbox_item_elements[0].find('div')[:id]).to eq('my-custom-conditional-id')
        end
      end

      context 'when there are other data attributes' do
        before { conditional_checkbox_item[0][:attributes] = { data: { test: 'data-test' } } }

        it 'has the correct attributes' do
          expect(checkbox_item_elements[0].find('input')[:'data-test']).to eq('data-test')
          expect(checkbox_item_elements[0].find('input')[:'data-aria-controls']).to eq('ouroboros_eunie_conditional')
        end
      end
    end
  end
end
