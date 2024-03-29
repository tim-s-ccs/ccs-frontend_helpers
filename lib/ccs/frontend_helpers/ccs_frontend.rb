# frozen_string_literal: true

require_relative 'ccs_frontend/dashboard_section'
require_relative 'ccs_frontend/footer'
require_relative 'ccs_frontend/header'

module CCS
  module FrontendHelpers
    # This module loads in all the CCS Frontend Helper methods.
    # These are a collection of view helpers to help render CCS components

    module CCSFrontend
      include DashboardSection
      include Footer
      include Header
    end
  end
end
