# frozen_string_literal: true

require 'action_view'

require_relative '../shared_methods'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Summary list
      #
      # This helper is used for generating the summary list component from the
      # {https://design-system.service.gov.uk/components/summary-list GDS - Components - Summary list}

      module SummaryList
        include SharedMethods
        include ActionView::Context
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::TextHelper
        include ActionView::Helpers::UrlHelper

        # Generates the HTML for the GOV.UK Summary list component
        #
        # @param summary_list_items [Array] the list of summary items. See {govuk_summary_list_row}
        # @param govuk_summary_list_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_summary_list_options [String] :classes additional CSS classes for the summary list HTML
        # @option govuk_summary_list_options [Hash] :attributes ({}) any additional attributes that will be added as part of the HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Summary list
        #                                     which can then be rendered on the page

        def govuk_summary_list(summary_list_items, **govuk_summary_list_options)
          if govuk_summary_list_options[:card]
            govuk_summary_card(**govuk_summary_list_options[:card]) do
              _govuk_summary_list(summary_list_items, govuk_summary_list_options)
            end
          else
            _govuk_summary_list(summary_list_items, govuk_summary_list_options)
          end
        end

        private

        # Generates the HTML for the GOV.UK Summary list.
        # Used in {govuk_summary_list} to gererate the actual summary list.
        #
        # @param (see govuk_summary_list)
        #
        # @option (see govuk_summary_list)
        #
        # @return (see govuk_summary_list)

        def _govuk_summary_list(summary_list_items, govuk_summary_list_options)
          initialise_attributes_and_set_classes(govuk_summary_list_options, 'govuk-summary-list')

          any_row_has_actions = summary_list_items.any? { |summary_list_item| summary_list_item.dig(:actions, :items).present? }

          tag.dl(**govuk_summary_list_options[:attributes]) do
            summary_list_items.each do |summary_list_item|
              concat(govuk_summary_list_row(summary_list_item, any_row_has_actions))
            end
          end
        end

        # rubocop:disable Metrics/AbcSize

        # Generates the HTML for a summary list row used in {govuk_summary_list}
        #
        # @param summary_list_item [Hash] the list of summary items
        # @param any_row_has_actions [Boolean] flag to indicate if any rows have actioms
        #
        # @option summary_list_item [String] :classes additional CSS classes for the summary row HTML
        # @option summary_list_item [Hash] :key the key for the summary list.
        #                                       Has the following options:
        #                                       - +:text+ - the text for the key
        #                                       - +:classes+ - additional classes for the key
        # @option summary_list_item [Hash] :value the value for the summary list.
        #                                       Has the following options:
        #                                       - +:text+ - the text for the value
        #                                       - +:classes+ - additional classes for the value
        # @option summary_list_item [Hash] :actions the actions for the summary list.
        #                                       Has the following options:
        #                                       - +:items+ - the action items (see {govuk_summary_list_action_link})
        #                                       - +:classes+ - additional classes for the actions
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for a summary list row
        #                                     used in {govuk_summary_list}

        def govuk_summary_list_row(summary_list_item, any_row_has_actions)
          item_has_actions = summary_list_item.dig(:actions, :items).present?
          summary_list_item_classes = "govuk-summary-list__row #{'govuk-summary-list__row--no-actions' if any_row_has_actions && !item_has_actions}".rstrip
          summary_list_item_classes += " #{summary_list_item[:classes]}".rstrip

          tag.div(class: summary_list_item_classes) do
            concat(tag.dt(summary_list_item[:key][:text], class: govuk_summary_list_cell_classes(:key, summary_list_item)))
            concat(tag.dd(summary_list_item[:value][:text], class: govuk_summary_list_cell_classes(:value, summary_list_item)))
            concat(tag.dd(govuk_summary_list_actions(summary_list_item[:actions]), class: govuk_summary_list_cell_classes(:actions, summary_list_item))) if item_has_actions
          end
        end

        # rubocop:enable Metrics/AbcSize

        # Generates the HTML for a summary list actions used in {govuk_summary_list_row}
        #
        # @param summary_list_actions [Hash] the actions for the summary list
        #
        # @option summary_list_actions [Hash] :items the action items (see {govuk_summary_list_action_link})
        # @option summary_list_actions [String] :classes additional CSS classes for the summary row HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the summary list actions
        #                                     used in {govuk_summary_list_row}

        def govuk_summary_list_actions(summary_list_actions)
          if summary_list_actions[:items].length == 1
            govuk_summary_list_action_link(summary_list_actions[:items].first)
          else
            tag.ul(class: 'govuk-summary-list__actions-list') do
              summary_list_actions[:items].each do |summary_list_actions_item|
                concat(tag.li(govuk_summary_list_action_link(summary_list_actions_item), class: 'govuk-summary-list__actions-list-item'))
              end
            end
          end
        end

        # Generates the HTML for a summary list action link used in {govuk_summary_list_actions}
        #
        # @param summary_list_action_item [Hash] an individual action ite,
        #
        # @option summary_list_action_item [String] :text text for the link
        # @option summary_list_action_item [String] :href href for the link
        # @option summary_list_action_item [String] :classes additional CSS classes for the summary link HTML
        # @option summary_list_action_item [Hash] :attributes ({}) any additional attributes that will added as part of the HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the summary list action link
        #                                     used in {govuk_summary_list_row}

        def govuk_summary_list_action_link(summary_list_action_item)
          initialise_attributes_and_set_classes(summary_list_action_item, 'govuk-link')

          link_to(summary_list_action_item[:href], **summary_list_action_item[:attributes]) do
            concat(summary_list_action_item[:text])
            concat(tag.span(summary_list_action_item[:visually_hidden_text], class: 'govuk-visually-hidden')) if summary_list_action_item[:visually_hidden_text]
          end
        end

        # rubocop:disable Metrics/AbcSize

        # Creates the wrapper for the govuk summary card used in {govuk_summary_list}
        #
        # @param govuk_summary_card_options [Hash] options for the summary card
        #
        # @option govuk_summary_card_options [Hash] :title options for the title section of the card header
        # @option govuk_summary_card_options [Hash] :actions options for the summary card actions section (see {govuk_summary_card_actions})
        # @option govuk_summary_card_options [String] :classes additional CSS classes for the summary card HTML
        # @option govuk_summary_card_options [Hash] :attributes ({}) any additional attributes that will be added as part of the HTML
        #
        # @option title [String] :text the title of the card
        # @option title [String] :heading_level (2) heading level, from 1 to 6
        # @option title [String] :classes additional classes to add to the title wrapper
        #
        # @yield HTML for the summary list (see {_govuk_summary_list})
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the summary card that
        #                                     wraps round {_govuk_summary_list} and
        #                                     used in {govuk_summary_list}

        def govuk_summary_card(**govuk_summary_card_options, &block)
          initialise_attributes_and_set_classes(govuk_summary_card_options, 'govuk-summary-card')

          tag.div(**govuk_summary_card_options[:attributes]) do
            concat(tag.div(class: 'govuk-summary-card__title-wrapper') do
              if govuk_summary_card_options[:title]
                govuk_summary_card_options[:title][:heading_level] ||= 2

                concat(tag.send(:"h#{govuk_summary_card_options[:title][:heading_level]}", govuk_summary_card_options[:title][:text], class: "govuk-summary-card__title #{govuk_summary_card_options[:title][:classes]}".rstrip))
              end
              concat(govuk_summary_card_actions(govuk_summary_card_options[:actions])) if govuk_summary_card_options[:actions]
            end)
            concat(tag.div(class: 'govuk-summary-card__content', &block))
          end
        end

        # rubocop:enable Metrics/AbcSize

        # Generates the HTML for a summary card actions used in {govuk_summary_card}
        #
        # @param actions [Hash] options for the summary card actions
        #
        # @option actions [String] :classes additional CSS classes for the summary card actions HTML
        # @option actions [Array] :items the action item objects which are passed to {govuk_summary_list_action_link}
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the summary card actions
        #                                     used in {govuk_summary_card}

        def govuk_summary_card_actions(actions)
          action_classes = "govuk-summary-card__actions #{actions[:classes]}".rstrip

          if actions[:items].length == 1
            tag.div(class: action_classes) do
              govuk_summary_list_action_link(actions[:items][0])
            end
          else
            tag.ul(class: action_classes) do
              actions[:items].each { |action_item| concat(tag.li(govuk_summary_list_action_link(action_item), class: 'govuk-summary-card__action')) }
            end
          end
        end

        # Generates a string containing the classes for the cell used in {govuk_summary_list_row}
        #
        # @param type [String] the type of the row. One of:
        #                      - +'key'+
        #                      - +'value'+
        #                      - +'actions'+
        # @param summary_list_item [Hash] see {govuk_summary_list_row}
        #
        # @return [String] the classes for a summary list cell

        def govuk_summary_list_cell_classes(type, summary_list_item)
          "govuk-summary-list__#{type} #{summary_list_item[type][:classes]}".rstrip
        end
      end
    end
  end
end
