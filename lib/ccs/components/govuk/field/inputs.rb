require_relative '../field'
require_relative '../fieldset'

module CCS::Components
  module GovUK
    class Field < Base
      # = GOV.UK Field Inputs
      #
      # This class is used to create a form for a list of fields, e.g. radios or checkboxes.
      # It will wrap the inputs in the form group and then the fieldset and:
      # - display the hint (if there is one)
      # - find and display the error message (if there is one)
      #
      # @!attribute [r] fieldset
      #   @return [Fieldset] The initialised fieldset

      class Inputs < Field
        private

        attr_reader :fieldset

        public

        # @param (see CCS::Components::GovUK::Field#initialize)
        # @param fieldset [Hash] attributes for the fieldset, see {CCS::Components::GovUK::Fieldset#initialize Fieldset#initialize} for more details.
        #
        # @option (see CCS::Components::GovUK::Field#initialize)

        def initialize(attribute:, fieldset:, **options)
          super(attribute: attribute, **options)

          set_described_by(fieldset, @attribute, @error_message, options[:hint])

          @fieldset = Fieldset.new(context: @context, **fieldset)
        end

        # Generates the HTML to wrap arround a GDS form component
        #
        # @yield (see CCS::Components::GovUK::Field#render)
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          super() do |display_error_message|
            fieldset.render do
              concat(hint.render) if hint
              concat(display_error_message)
              concat(yield)
            end
          end
        end
      end
    end
  end
end
