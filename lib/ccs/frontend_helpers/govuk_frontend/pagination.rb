# frozen_string_literal: true

require 'action_view'

require_relative '../shared_methods'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # rubocop:disable Metrics/ModuleLength

      # = GOV.UK Pagination
      #
      # This helper is used for generating the pagination component from the
      # {https://design-system.service.gov.uk/components/pagination GDS - Components - Pagination}

      module Pagination
        include SharedMethods
        include ActionView::Context
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::TextHelper
        include ActionView::Helpers::UrlHelper

        # Generates the HTML for the GOV.UK Pagination component
        #
        # @param (see _govuk_pagination)
        #
        # @option (see _govuk_pagination)
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Pagination
        #                                     which can then be rendered on the page

        def govuk_pagination(**govuk_pagination_options)
          _govuk_pagination(**govuk_pagination_options) do |block_is_level|
            concat(govuk_pagination_previous(block_is_level, form: govuk_pagination_options[:form], **govuk_pagination_options[:previous])) if govuk_pagination_options[:previous]
            concat(govuk_pagination_items(govuk_pagination_options[:items], form: govuk_pagination_options[:form])) if govuk_pagination_options[:items]
            concat(govuk_pagination_next(block_is_level, form: govuk_pagination_options[:form], **govuk_pagination_options[:next])) if govuk_pagination_options[:next]
          end
        end

        private

        # Wrapper method used by {govuk_pagination}
        #
        # @param govuk_pagination_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_pagination_options [ActionView::Helpers::FormBuilder] :form (nil) optional form builder used to create pagination buttons
        # @option govuk_pagination_options [String] :classes additional CSS classes for the pagination HTML
        # @option govuk_pagination_options [Array] :items an array of items for the pagination (see: {govuk_pagination_items})
        # @option govuk_pagination_options [Hash] :previous the previous link (see: {govuk_pagination_previous})
        # @option govuk_pagination_options [Hash] :next the next link (see: {govuk_pagination_next})
        # @option govuk_pagination_options [Hash] :attributes ({role: 'navigation', aria: { label: 'results' }})
        #                                         any additional attributes that will added as part of the HTML
        #
        # @yield the pagination HTML generated by {govuk_pagination}
        #
        # @yieldparam block_is_level [Boolean] flag to indicate if there are no items
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the Pagination
        #                                     which is used in {govuk_pagination}

        def _govuk_pagination(**govuk_pagination_options)
          initialise_attributes_and_set_classes(govuk_pagination_options, 'govuk-pagination')

          block_is_level = govuk_pagination_options[:items].blank? && (govuk_pagination_options[:next].present? || govuk_pagination_options[:previous].present?)

          govuk_pagination_options[:attributes][:class] << ' govuk-pagination--block' if block_is_level

          govuk_pagination_options[:attributes][:role] = 'navigation'
          (govuk_pagination_options[:attributes][:aria] ||= {})[:label] ||= 'results'

          tag.nav(**govuk_pagination_options[:attributes]) do
            yield(block_is_level)
          end
        end

        # Generates the previous link for {govuk_pagination}
        #
        # @param (see govuk_pagination_previous_content)
        #
        # @option (see govuk_pagination_previous_content)
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the previous link which is used in {govuk_pagination}

        def govuk_pagination_previous(block_is_level, **govuk_pagination_previous_options)
          govuk_pagination_previous_options[:attributes] ||= {}
          govuk_pagination_previous_options[:attributes][:class] = "govuk-link govuk-pagination__link #{'pagination--button_as_link' if govuk_pagination_previous_options[:form]}".rstrip
          govuk_pagination_previous_options[:attributes][:rel] = 'prev'

          pagination_previous_content = govuk_pagination_previous_content(block_is_level, govuk_pagination_previous_options)

          tag.div(class: 'govuk-pagination__prev') do
            if govuk_pagination_previous_options[:form]
              govuk_pagination_previous_options[:form].button(pagination_previous_content, **govuk_pagination_previous_options[:attributes])
            else
              link_to(pagination_previous_content, govuk_pagination_previous_options[:href], **govuk_pagination_previous_options[:attributes])
            end
          end
        end

        # Used by {govuk_pagination_previous}
        # to generate the previous link content
        #
        # @param block_is_level [Boolean] when there are no items, this will be true and will add extra classes
        #                                 to the link to make the next and previous pagination links level
        # @param govuk_pagination_previous_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_pagination_previous_options [ActionView::Helpers::FormBuilder] :form (nil) optional form builder used to create previous button
        # @option govuk_pagination_previous_options [String] :href the URL for the link
        # @option govuk_pagination_previous_options [String] :text ('Previous') the text for the link
        # @option govuk_pagination_previous_options [String] :lable_text additional text for the link when the pagination block is level
        # @option govuk_pagination_previous_options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the previous link/button

        def govuk_pagination_previous_content(block_is_level, govuk_pagination_previous_options)
          capture do
            concat(govuk_pagination_icon(:prev))
            concat(tag.span(govuk_pagination_previous_options[:text] || 'Previous', class: pagination_next_and_previous_classes(block_is_level, govuk_pagination_previous_options)))
            concat(govuk_pagination_icon_label_text(block_is_level, govuk_pagination_previous_options[:lable_text]))
          end
        end

        # Generates the next link for {govuk_pagination}
        #
        # @param (see govuk_pagination_next_content)
        #
        # @option (see govuk_pagination_next_content)
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the next link which is used in {govuk_pagination}

        def govuk_pagination_next(block_is_level, **govuk_pagination_next_options)
          govuk_pagination_next_options[:attributes] ||= {}
          govuk_pagination_next_options[:attributes][:class] = "govuk-link govuk-pagination__link #{'pagination--button_as_link' if govuk_pagination_next_options[:form]}".rstrip
          govuk_pagination_next_options[:attributes][:rel] = 'next'

          pagination_next_content = govuk_pagination_next_content(block_is_level, **govuk_pagination_next_options)

          tag.div(class: 'govuk-pagination__next') do
            if govuk_pagination_next_options[:form]
              govuk_pagination_next_options[:form].button(pagination_next_content, **govuk_pagination_next_options[:attributes])
            else
              link_to(pagination_next_content, govuk_pagination_next_options[:href], **govuk_pagination_next_options[:attributes])
            end
          end
        end

        # Used by {govuk_pagination_next} to generate the next link content
        #
        # @param block_is_level [Boolean] when there are no items, this will be true and will add extra classe
        #                                 to the link to make the next and previous pagination links level
        # @param govuk_pagination_next_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_pagination_next_options [ActionView::Helpers::FormBuilder] :form (nil) optional form builder used to create next button
        # @option govuk_pagination_next_options [String] :href the URL for the link
        # @option govuk_pagination_next_options [String] :text ('Next') the text for the link
        # @option govuk_pagination_next_options [String] :lable_text additional text for the link when the pagination block is level
        # @option govuk_pagination_next_options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the next link/button

        def govuk_pagination_next_content(block_is_level, **govuk_pagination_next_options)
          capture do
            concat(govuk_pagination_icon(:next)) if block_is_level
            concat(tag.span(govuk_pagination_next_options[:text] || 'Next', class: pagination_next_and_previous_classes(block_is_level, govuk_pagination_next_options)))
            concat(govuk_pagination_icon_label_text(block_is_level, govuk_pagination_next_options[:lable_text]))
            concat(govuk_pagination_icon(:next)) unless block_is_level
          end
        end

        # Returns the classes for the previous and next link/button label
        #
        # @param (see govuk_pagination_next_content)

        def pagination_next_and_previous_classes(block_is_level, govuk_pagination_options)
          "govuk-pagination__link-title #{'govuk-pagination__link-title--decorated' if block_is_level && !govuk_pagination_options[:lable_text]}".rstrip
        end

        # Generates the item links for {govuk_pagination}
        #
        # @param (see _govuk_pagination_items)
        # @param form [ActionView::Helpers::FormBuilder] optional form builder used to create the item buttons
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the lits of items which is used in {govuk_pagination}

        def govuk_pagination_items(govuk_pagination_items, form:)
          if form
            _govuk_pagination_items(govuk_pagination_items) do |govuk_pagination_item|
              govuk_pagination_item_number_form(form, govuk_pagination_item)
            end
          else
            _govuk_pagination_items(govuk_pagination_items) do |govuk_pagination_item|
              govuk_pagination_item_number_tag(govuk_pagination_item)
            end
          end
        end

        # Wrapper method used by {govuk_pagination_items}
        # to generate the pagination items HTML
        #
        # @param govuk_pagination_items [Array(Hash)] an array of item hashes for the pagination.
        #                                             There are two types of item:
        #                                             - {govuk_pagination_item_ellipsis ellipsis item}
        #                                             - {govuk_pagination_item_number_tag number item}
        #
        # @yield the pagination number item HTML generated by {govuk_pagination_items}
        #
        # @yieldparam govuk_pagination_item [Hash] the current pagination item in the loop
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the lits of items which is
        #                                     used in {govuk_pagination_items}

        def _govuk_pagination_items(govuk_pagination_items)
          tag.ul(class: 'govuk-pagination__list') do
            govuk_pagination_items.each do |govuk_pagination_item|
              case govuk_pagination_item[:type]
              when :ellipsis
                concat(govuk_pagination_item_ellipsis)
              when :number
                concat(yield(govuk_pagination_item))
              end
            end
          end
        end

        # Generates the icon for:
        # - {govuk_pagination_previous}
        # - {govuk_pagination_next}
        #
        # @param type [Symbol] the type of the pagination icon (+:prev+ or +:next+)
        #
        # @return [ActiveSupport::SafeBuffer]

        def govuk_pagination_icon(type)
          tag.svg(class: "govuk-pagination__icon govuk-pagination__icon--#{type}", xmlns: 'http://www.w3.org/2000/svg', height: '13', width: '15', aria: { hidden: 'true' }, focusable: 'false', viewBox: '0 0 15 13') do
            tag.path(d: PAGINATION_ICON_PATHS[type])
          end
        end

        # Generates the label text for:
        # - {govuk_pagination_previous}
        # - {govuk_pagination_next}
        #
        # @param block_is_level [Boolean] when there are no items, this will be true
        # @param label_text [String] the additional text for the link
        #
        # @return [ActiveSupport::SafeBuffer]

        def govuk_pagination_icon_label_text(block_is_level, label_text)
          return unless block_is_level && label_text

          concat(tag.span(':', class: 'govuk-visually-hidden'))
          concat(tag.span(label_text, class: 'govuk-pagination__link-label'))
        end

        # Generates the ellipsis HTML for {govuk_pagination_items}
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for an ellipsis item which is used in {govuk_pagination_items}

        def govuk_pagination_item_ellipsis
          tag.li('⋯', class: 'govuk-pagination__item govuk-pagination__item--ellipses')
        end

        # Generates the number item HTML for {govuk_pagination_items}
        #
        # @param (see _govuk_pagination_item_number)
        #
        # @option (see _govuk_pagination_item_number)
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for an number item which is used in {govuk_pagination_items}

        def govuk_pagination_item_number_tag(govuk_pagination_item)
          _govuk_pagination_item_number(govuk_pagination_item) do
            link_to(govuk_pagination_item[:number], govuk_pagination_item[:href], **govuk_pagination_item[:attributes])
          end
        end

        # Generates the number item HTML for {govuk_pagination_items} when there is a ActionView::Helpers::FormBuilder
        #
        # @param form [ActionView::Helpers::FormBuilder] the form builder used to create the item button
        # @param (see _govuk_pagination_item_number)
        #
        # @option (see _govuk_pagination_item_number)
        #
        # @return (see govuk_pagination_item_number_tag)

        def govuk_pagination_item_number_form(form, govuk_pagination_item)
          govuk_pagination_item[:classes] = 'pagination-number--button_as_link'

          _govuk_pagination_item_number(govuk_pagination_item) do
            form.button(govuk_pagination_item[:number], **govuk_pagination_item[:attributes])
          end
        end

        # Wrapper method used by {govuk_pagination_item_number_tag} and {govuk_pagination_item_number_form}
        # to generate the pagination number item HTML
        #
        # @param govuk_pagination_item [Hash] options that will be used in customising the HTML
        #
        # @option govuk_pagination_item [String] :href the URL for the link
        # @option govuk_pagination_item [String] :number the number for the link
        # @option govuk_pagination_item [String] :current is this item the current page
        # @option govuk_pagination_item [Hash] :attributes ({aria: { label: 'Page <NUMBER>' } })
        #                                                  any additional attributes that will added as part of the HTML
        #
        # @yield the pagination number item link (when {govuk_pagination_item_number_tag}) or button (when {govuk_pagination_item_number_form})
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for an number item which is used
        #                                     in {govuk_pagination_item_number_tag} or {govuk_pagination_item_number_form}

        def _govuk_pagination_item_number(govuk_pagination_item, &block)
          initialise_attributes_and_set_classes(govuk_pagination_item, 'govuk-link govuk-pagination__link')

          (govuk_pagination_item[:attributes][:aria] ||= {})[:label] ||= "Page #{govuk_pagination_item[:number]}"

          govuk_pagination_list_classes = +'govuk-pagination__item'

          if govuk_pagination_item[:current]
            govuk_pagination_list_classes << ' govuk-pagination__item--current'
            govuk_pagination_item[:attributes][:aria][:current] = 'page'
          end

          tag.li(class: govuk_pagination_list_classes, &block)
        end

        # The paths for the pagination next and previous icons

        PAGINATION_ICON_PATHS = {
          prev: 'm6.5938-0.0078125-6.7266 6.7266 6.7441 6.4062 1.377-1.449-4.1856-3.9768h12.896v-2h-12.984l4.2931-4.293-1.414-1.414z',
          next: 'm8.107-0.0078125-1.4136 1.414 4.2926 4.293h-12.986v2h12.896l-4.1855 3.9766 1.377 1.4492 6.7441-6.4062-6.7246-6.7266z'
        }.freeze
      end
      # rubocop:enable Metrics/ModuleLength
    end
  end
end
