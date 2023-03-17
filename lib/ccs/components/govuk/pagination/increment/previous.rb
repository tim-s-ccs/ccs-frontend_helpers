require_relative '../increment'

module CCS::Components
  module GovUK
    class Pagination < Base
      class Increment < Base
        # = GOV.UK Pagination Previous
        #
        # This generates the HTML for the pagination previous link

        class Previous < Increment
          # @param (see Increment#initialize)
          #
          # @option (see Increment#initialize)

          def initialize(text: 'Previous', **options)
            super(type: :prev, text: text, **options)
          end

          # Generates the HTML for the previous link in the pagination
          #
          # @return [ActiveSupport::SafeBuffer]

          def render
            tag.div(class: 'govuk-pagination__prev') do
              super() do
                concat(pagination_icon)
                concat(tag.span(text, class: pagination_text_classes))
                pagination_icon_label_text
              end
            end
          end

          # The path for the pagination previous icon

          PAGINATION_ICON_PATH = 'm6.5938-0.0078125-6.7266 6.7266 6.7441 6.4062 1.377-1.449-4.1856-3.9768h12.896v-2h-12.984l4.2931-4.293-1.414-1.414z'.freeze
        end
      end
    end
  end
end
