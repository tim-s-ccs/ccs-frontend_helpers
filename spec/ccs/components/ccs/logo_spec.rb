# frozen_string_literal: true

require 'ccs/components/ccs/logo'

RSpec.describe CCS::Components::CCS::Logo do
  include_context 'and I have a view context'

  let(:logo_element) { Capybara::Node::Simple.new(result).find('span.ccs-logo') }

  describe '.render' do
    let(:ccs_logo) { described_class.new(context: view_context) }
    let(:result) { ccs_logo.render }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML for the logo' do
        expect(logo_element.to_html).to eq('
          <span class="ccs-logo">
            <svg class="ccs-logo__svg" xmlns="http://www.w3.org/2000/svg" height="101" width="121" aria-hidden="true" focusable="false" viewbox="0 0 121 101">
              <path fill="currentColor" fill-rule="evenodd" d="M1.9.4H0v99.8h1.9V.4zm20 43c-.4-2.2-2.1-3.3-4.3-3.3-3.7 0-5.3 3-5.3 6.3 0 3.6 1.6 6.6 5.3 6.6 2.7 0 4.3-2 4.5-4.5h2c-.3 3.9-2.8 6.2-6.7 6.2-4.8 0-7.2-3.5-7.2-8 0-4.6 2.6-8.3 7.4-8.3 3.3 0 6 1.8 6.4 5h-2zm4-.3h1.7v2.3c1-1.8 2.2-2.7 4.2-2.6v2c-3 0-4.1 1.7-4.1 4.5v5h-1.8zm11.6-.3c3.6 0 5.5 2.6 5.5 5.9s-2 5.9-5.5 5.9c-3.6 0-5.5-2.6-5.5-6 0-3.2 2-5.8 5.5-5.8zm0 10.1c2 0 3.5-1.5 3.5-4.3s-1.6-4.2-3.5-4.2c-2 0-3.5 1.5-3.5 4.2 0 2.8 1.6 4.3 3.5 4.3zm18 1.4h-2l-2.4-9-2.3 9h-2l-3.6-11.2h2l2.6 9.2 2.3-9.2h2l2.4 9.2L57 43h2zm4.8-11.2H62v1.8a4 4 0 0 1 3.7-2.1c3 0 4 1.7 4 4.1v7.4h-2v-7.6c0-1.4-.8-2.2-2.2-2.2-2.3 0-3.4 1.5-3.4 3.5v6.4h-1.8V43zM22 66.4c-.5-2.2-2.2-3.3-4.4-3.3-3.7 0-5.3 3-5.3 6.3 0 3.5 1.6 6.5 5.3 6.5 2.7 0 4.3-2 4.5-4.5h2c-.3 3.9-2.7 6.2-6.7 6.2-4.8 0-7.2-3.5-7.2-8 0-4.6 2.6-8.3 7.4-8.3 3.3 0 6 1.8 6.4 5.1h-2zm8.8-.7c3.6 0 5.5 2.6 5.5 6s-1.9 5.8-5.5 5.8-5.4-2.6-5.4-5.9 1.9-5.9 5.4-5.9zm0 10.1c2 0 3.6-1.5 3.6-4.2s-1.6-4.3-3.6-4.3-3.5 1.5-3.5 4.3c0 2.7 1.6 4.2 3.5 4.2zM38 66h1.7v1.6c1-1.2 2.2-1.9 3.8-1.9 1.3 0 2.6.5 3 2a4.2 4.2 0 0 1 3.6-2c2.2 0 3.7 1 3.7 3.3v8.2H52v-7.4c0-1.4-.4-2.5-2.2-2.5-1.8 0-3 1.2-3 2.9v7H45v-7.4c0-1.5-.4-2.5-2.1-2.5-2.2 0-3 2-3 2.9v7H38V66zm18 0h2v1.6a4.4 4.4 0 0 1 3.7-1.9c1.3 0 2.6.5 3 2a4.2 4.2 0 0 1 3.6-2c2.2 0 3.7 1 3.7 3.3v8.2h-1.8v-7.4c0-1.4-.4-2.5-2.2-2.5-1.8 0-3 1.2-3 2.9v7h-1.8v-7.4c0-1.5-.5-2.5-2.1-2.5-2.2 0-3 2-3 2.9v7H56V66zm27.7 7.6c-.5 2.5-2.3 3.9-4.8 3.9-3.6 0-5.3-2.5-5.4-6 0-3.4 2.2-5.8 5.3-5.8 4 0 5.2 3.7 5 6.4h-8.4c0 2 1 3.7 3.5 3.7 1.6 0 2.7-.7 3-2.2zm-1.8-3c0-1.9-1.4-3.3-3.2-3.3-2 0-3.1 1.5-3.2 3.2zm3.5-4.6h1.8v2.3c.9-1.8 2.2-2.6 4.1-2.6v2c-3 0-4 1.7-4 4.5v5h-2V66zm14.4 3.6c-.2-1.4-1.3-2.3-2.8-2.3-2.7 0-3.5 2.2-3.5 4.4 0 2.1 1 4.2 3.3 4.2 1.8 0 2.9-1 3.1-2.7h1.9c-.4 2.7-2.2 4.3-5 4.3-3.4 0-5.3-2.4-5.3-5.8s1.8-6 5.4-6c2.5 0 4.5 1.2 4.8 3.9H100zm5.5-5.7h-1.8v-2.2h1.8zm-1.8 2h1.8v11.3h-1.8V66zm14.1 11.3c-.3.2-.7.3-1.3.3-1 0-1.6-.5-1.6-1.7a5 5 0 0 1-4 1.7c-2 0-3.7-1-3.7-3.2 0-2.5 1.9-3 3.8-3.4 2.1-.4 3.8-.3 3.8-1.7 0-1.6-1.3-2-2.5-2-1.6 0-2.7.6-2.8 2.2h-1.9c.1-2.8 2.3-3.8 4.8-3.8 2 0 4.2.5 4.2 3.1v5.8c0 .9 0 1.3.6 1.3h.6v1.4zm-3-5.8c-.7.5-2 .5-3.3.7-1.3.3-2.3.7-2.3 2s1 1.7 2.2 1.7c2.5 0 3.5-1.5 3.5-2.5v-2zm4.4-9.8h1.9v15.6H119zM20 89.1c-.3-2.2-1.8-3.1-4-3.1-1.7 0-3.4.6-3.4 2.6s2.4 2.2 5 2.8c2.4.6 5 1.4 5 4.5 0 3.3-3.3 4.6-6.2 4.6-3.4 0-6.4-1.7-6.4-5.5h2c0 2.6 2.1 3.8 4.5 3.8 2 0 4-.6 4-2.9 0-2-2.5-2.5-5-3s-5-1.3-5-4.1c0-3.2 2.9-4.6 5.7-4.6 3.2 0 5.6 1.5 5.7 5zm14 7.5a4.8 4.8 0 0 1-4.9 3.8c-3.6 0-5.3-2.5-5.4-6 0-3.4 2.2-5.8 5.3-5.8 4 0 5.2 3.7 5 6.5h-8.4c0 2 1 3.7 3.5 3.7 1.6 0 2.6-.8 3-2.2H34zm-1.9-3.2c0-1.7-1.4-3.2-3.3-3.2s-3 1.5-3.2 3.2zm3.5-4.5h1.8v2.4c.9-1.8 2.2-2.7 4.1-2.7v2c-3 0-4 1.7-4 4.5v5h-2V89zm12.6 11.3h-2L42 88.9h2.1l3.2 9.4 3.1-9.4h2l-4.2 11.3zm7.2-13.3h-1.9v-2.3h1.9V87zm-1.9 2h1.9v11.3h-1.9V88.9zm12 3.6c-.3-1.4-1.3-2.3-2.8-2.3-2.7 0-3.6 2.2-3.6 4.5 0 2 1 4.1 3.4 4.1 1.8 0 2.8-1 3-2.7h2c-.5 2.7-2.2 4.3-5 4.3-3.5 0-5.3-2.4-5.3-5.7s1.7-6 5.3-6c2.6 0 4.6 1.1 4.8 3.8zm13.2 4c-.5 2.5-2.3 3.9-4.8 3.9-3.6 0-5.3-2.5-5.4-6 0-3.4 2.2-5.8 5.2-5.8 4 0 5.2 3.7 5.2 6.5h-8.5c0 2 1 3.7 3.5 3.7 1.6 0 2.6-.8 3-2.2h1.8zm-1.8-3c-.1-1.8-1.4-3.3-3.3-3.3-2 0-3 1.5-3.2 3.2zM25.6 5c-.2.3-.4.5-.3.8l.4.7.3-.8-.4-.7zm4.6 0c.1.3.3.5.3.8 0 .2-.3.4-.5.7 0-.3-.3-.6-.3-.8 0-.2.4-.6.5-.7zm-7.3-.2a.3.3 0 0 0 .3-.3.3.3 0 0 0-.3-.3.3.3 0 0 0-.3.3.3.3 0 0 0 .3.3zm.3.4a.3.3 0 0 0-.3-.3.3.3 0 0 0-.4.3c0 .2.2.3.4.3a.3.3 0 0 0 .3-.3zm0 .8a.3.3 0 0 0-.2-.3.3.3 0 0 0-.3.3c0 .2.1.3.3.3a.3.3 0 0 0 .3-.3zm1.5-2.7A.3.3 0 0 0 25 3a.3.3 0 0 0-.3-.3.3.3 0 0 0-.3.3c0 .2 0 .3.3.3zm-.8.3a.3.3 0 0 0 .3-.4.3.3 0 0 0-.3-.3.3.3 0 0 0-.3.3c0 .2.1.4.3.4zm-.6.5a.3.3 0 0 0 .3-.3.3.3 0 0 0-.3-.3.3.3 0 0 0-.3.3c0 .2.1.3.3.3zm2.2-.7a.3.3 0 0 0 .3-.3.3.3 0 0 0-.3-.3.3.3 0 0 0-.4.3c0 .1.2.3.4.3zm.7.2a.3.3 0 0 0 .4-.3.3.3 0 0 0-.4-.3.3.3 0 0 0-.3.3c0 .2.2.3.3.3zm.8.4a.3.3 0 0 0 .3-.4.3.3 0 0 0-.3-.3.3.3 0 0 0-.4.3c0 .2.2.4.4.4zm5.5.5c0 .2.1.3.3.3a.3.3 0 0 0 .3-.3.3.3 0 0 0-.3-.3.3.3 0 0 0-.3.3zm.4.4a.3.3 0 0 0-.3.3c0 .2 0 .3.3.3a.3.3 0 0 0 .3-.3.3.3 0 0 0-.3-.3zm-.2.8a.3.3 0 0 0-.3.3c0 .2.2.3.3.3A.3.3 0 0 0 33 6a.3.3 0 0 0-.3-.3zm-1.6-2.4a.3.3 0 0 0 .3-.3.3.3 0 0 0-.3-.3.3.3 0 0 0-.4.3c0 .2.2.3.4.3zm.8.3a.3.3 0 0 0 .3-.4.3.3 0 0 0-.4-.3.3.3 0 0 0-.3.3c0 .2.2.4.4.4zm.5.5a.3.3 0 0 0 .3-.3.3.3 0 0 0-.3-.3.3.3 0 0 0-.3.3c0 .2.2.3.3.3zm-2.1-.7a.3.3 0 0 0 .3-.3.3.3 0 0 0-.3-.3.3.3 0 0 0-.3.3c0 .1 0 .3.3.3zm-.8.2a.3.3 0 0 0 .3-.3.3.3 0 0 0-.3-.3.3.3 0 0 0-.3.3c0 .2.1.3.3.3zm-1 0c0 .2 0 .4.3.4a.3.3 0 0 0 .3-.4.3.3 0 0 0-.3-.3.3.3 0 0 0-.3.3zm-1.1 1.7h.3V4.1h-.3zm1-1.4a.8.8 0 0 1-.3 0v1.4h.3zm-.7-1.5v-.7a1 1 0 0 0-.8.8h.8zm.4 0h.7a1 1 0 0 0-.7-.8z"></path>
              <path d="M27 3c0 .3.4.7.9.7a1 1 0 0 0 1-.8zm1.4-1.4a.8.8 0 0 1-.4-.7c.2 0 .5.2.7.5v-1l-.7.3c0-.2.1-.4.4-.7h-1c.2.3.3.5.3.8-.2 0-.5-.3-.7-.5v1l.7-.4c0 .3-.2.6-.4.7zm0 22.2a.4.4 0 0 1-.4-.4.4.4 0 1 1 .8 0c0 .2-.2.4-.4.4zm-1.8-.6a.4.4 0 0 1-.4-.4c0-.2.2-.4.4-.4s.4.2.4.4-.2.4-.4.4zm-.6-1.8l-.1-.1h-.5l-.3.2v.1c.3.3.3.4.2.5v.1h-.5l-.1-.1v.1l-.1.1a.7.7 0 0 0-.2.4 1 1 0 0 0 .2.3l.4.2a.6.6 0 0 1-.6 0l-.4-.6c0-.2 0-.5.3-.8v-.1l-.1-.3h.3c.2-.1.6-.5 1-.5a.7.7 0 0 1 .5.2l.2.4a.3.3 0 0 1-.2-.1zm3.6 1.4a23.8 23.8 0 0 1-3.3-1.1.8.8 0 0 0-.2-.7l-.6-.3h-.3c-.2 0-.3-.3-.5-.4a5.7 5.7 0 0 1-1-1.7 4.5 4.5 0 0 1-.2-1c0 .2-.4.7-1 .7V18c-.2.1-.4.3-1 .1 0 .5.2.9.3 1.3a6.6 6.6 0 0 0 1.4 2.4l.7.6v.1c0 .2.2.6.5.8l.8-.1a5 5 0 0 0 1.7.6 7 7 0 0 0 2 .3c.5 0 1.1-.2 1.7-.6l.7-.5a5 5 0 0 1-1.7-.3zm-.4 4l-.2-.2c-.4 0-.2 1-.7 1-.2 0-.3-.1-.3-.2V27l-.1-.2c-.1 0-.2 0-.2.2v.3c0 .1 0 .2-.2.2-.5 0-.3-1-.7-1-.1 0-.2 0-.3.2a.8.8 0 0 1-.1-.4c0-.2.1-.4.4-.4.6 0 .4.7.7.7l.2-.2c0-.2-.4-.4-.4-.7 0-.3.3-.6.6-.8.3.2.6.5.6.8 0 .3-.4.5-.4.7a.2.2 0 0 0 .2.2c.2 0 .1-.7.6-.7.3 0 .5.2.5.4l-.2.4zM28 28.2a.3.3 0 0 1-.3-.2c0-.1.1-.3.3-.3s.2.2.2.3a.3.3 0 0 1-.2.2zm1-2.5h-.1v-1.1a6.3 6.3 0 0 1-1.8-.3v1.4h-.2c-.4 0-.6.3-.6.7 0 .3.1.5.3.7 0-.2.1-.3.2-.3.3 0 .1 1 .7 1v.2c0 .3.2.5.5.5s.4-.3.4-.5c.5 0 .5-1.1.7-1.1 0 0 .2.1.2.3.2-.2.4-.4.4-.7 0-.4-.3-.7-.7-.7z"></path>
              <path d="M42.6 27.1h-.1c-1.4.3-3-.8-4.7-1.9-1.4-1-2.7-1.8-3.8-1.8-.4 0-.8.1-1 .3a2 2 0 0 0-1 1l-.5 1-.3.8c0 .2 0 .4.3.6.1.2.3.4.7.5l.2.1.5.4a9.5 9.5 0 0 1-2 .5l-3 .3c-1 0-2-.1-2.9-.3a9.4 9.4 0 0 1-2-.5c0-.2.2-.3.5-.5h.2l.7-.5.3-.6-.4-.8a5.3 5.3 0 0 1-.5-1 2 2 0 0 0-.9-1c-.3-.2-.6-.3-1-.3-1.2 0-2.5 1-3.9 1.8-1.6 1.1-3.3 2.2-4.6 1.8l-.2.1.1.2 1.2.7c.5.4 1 .8 1.4.8.5 0 1-.2 1.7-.5a25.3 25.3 0 0 0 1.6-1 7 7 0 0 1 3.3-1.7c0 .2-.2.3-.3.4-.3.2-.6.5-.6 1 0 .4.1.6.3 1l.2.4.2.8.1.4c.1.3.2.7 1 1.1.9.5 2.4.7 4.6.7 2.1 0 3.7-.2 4.6-.7.7-.4.8-.9 1-1v-.5l.2-.8.3-.5c.1-.3.3-.5.3-.8 0-.5-.3-.8-.7-1.1l-.3-.3c1.1 0 2.2.8 3.3 1.6l1.7 1c.6.3 1.1.5 1.6.5s1-.3 1.5-.7l1.1-.8v-.2zM28.1 16.5v-5c.5 0 1 0 1.5.3s1 .6 1.4 1.1c.4.5.8 1 1 1.7a5.8 5.8 0 0 1 .3 2h-4.2zm-.2-7.2c-1.5 0-2.5.4-3 .8-.4-.2-.5-.4-.5-.6 0-.9 2.3-1 3.5-1s3.5.2 3.5 1c0 .2-.1.4-.5.6-.6-.4-1.6-.8-3-.8zm-.1 7.2h-4.4a5.8 5.8 0 0 1 1.3-3.6c.4-.5 1-.8 1.5-1a3.6 3.6 0 0 1 1.6-.5zm6.6-.3c-.1-.1-.4-.3-.5-.6l-1-1.9a.7.7 0 0 1 0-.3V13l.3-.3.1-.2c-.2-.4-.4-.7-.8-1a6.5 6.5 0 0 0-1.3-1.2c.3-.2.5-.4.5-.9a.7.7 0 0 0-.2-.5c.2-1 .7-2 1.1-2.4l-.8-.4c.2.4.2.8.1 1-.2-.2-.4-.4-.4-.7a4.1 4.1 0 0 1-.4 1c.3-.1.5-.2.7 0 0 .1-.5.4-1 .3-.4-.1-.7-.3-.7-.5l.3-.3c.2 0 .3.3.2.4.2-.1.5-.9.1-1-.3 0-.6.4-.7.7 0-.4-.2-.7-.5-.7-.4 0-.3.7-.2 1 0-.3.2-.5.3-.5.1 0 .3.1.3.3s-.4.4-.8.4c-.3 0-1-.1-1-.8.1 0 .5.2.7.5a5.4 5.4 0 0 1 0-1.2c-.2.3-.5.4-.7.5a1.6 1.6 0 0 1 .6-.9H27c.3.2.6.6.6.9-.2 0-.6-.2-.7-.5v1.2c.1-.2.5-.4.7-.5 0 .7-.7.9-1 .9-.5 0-.8-.2-.8-.4a.2.2 0 0 1 .2-.3c.1 0 .3.1.3.4.1-.2.2-1-.2-1-.3 0-.4.4-.5.8 0-.4-.4-.8-.7-.7-.4 0-.1.8.1 1 0-.2 0-.5.2-.5s.3.2.3.3c0 .2-.3.4-.6.5a1 1 0 0 1-1.1-.3c.2-.2.4 0 .7 0a4.1 4.1 0 0 1-.3-1l-.5.7c0-.2 0-.7.2-1l-1 .3c.5.5 1 1.5 1.3 2.4a.7.7 0 0 0-.3.6c0 .4.3.6.5.8-.5.3-1 .7-1.3 1.2-.6.6-1 1.4-1.4 2.3l.7.8c.3.3.4.6.4.8 0 .4 0 .6.3.8l.2.6h4.4v4.7c-.2 0-.4 0-.5.2l1.5.6c0-.3 0-.5.2-.7l-1-.1v-4.6h4.3c0 .7-.1 1.3-.4 1.8a4.9 4.9 0 0 1-2.3 2.8l-.2.1-.2.4-.1.5.5.1c1.5.4 1.8.3 1.9.2l1-.8c.5-.7 1-1.5 1.3-2.4a8 8 0 0 0 .6-2.8v-.5z"></path>
              <path d="M30.4 13.5v.1l.1.1v.2h.2c.3.6.6 1.2.7 1.8h-.2v.1h-1v-.1H30a.3.3 0 0 0-.1-.1.3.3 0 0 0 0 .1h-.2l-.1.1h-1l.1-.2-.2.1v-1.4l.2-.1V14a.3.3 0 0 0 0-.1.3.3 0 0 0 0-.1v-.2h-.2v-1.3h.2v-.1l.8.4.8.8zm1.2 2.2c.1 0 0 .2 0 .2a4.8 4.8 0 0 0-.9-2.2c.1 0 .2 0 .2-.2l-.2.1-.1-.1-1-.9-1-.5h.2c0-.2 0-.2-.2-.2h-.2v.2h-.1l.1.3v-.1 1.6l-.2.1.3.1v1.8c-.1 0-.2-.1 0-.2-.2 0-.3.2-.3.2h.2l-.1.2h.2l.2-.1h-.2 1.3v.2c.2 0 .2-.2.2-.2h1.2l.2.2s.1 0 0-.2l.2.1v-.2c.2 0 .2-.2 0-.2z"></path>
              <path d="M30.9 15.2h.1-.1V15c0-.1 0-.1-.1 0s-.4 0-.4-.3h.4l-.2-.4-.2-.1v-.4l-.1-.2v.6l.5.4-.1.1h-.1a.1.1 0 0 1-.1-.1l-.3-.4c-.2-.2-.1-.4 0-.5l-.2-.5v-.1l-.2-.1h-.2l-.1.2v.1h.2-.1v.1l.2.1c0 .2-.2.2-.2.3h-.1l-.2-.2-.1-.1v-.3H29v.1c0-.1-.1-.2-.2-.1h.2l-.1.1v.1c0 .1 0 .1 0 0a.1.1 0 0 0 0 .2l.1.1c.1 0 .2.3.4.3l-.2.2a.3.3 0 0 1-.2.1h-.2v.1s-.1.1 0 .2v-.1.1h.4c.1 0 0 0 0 0l.2-.1h.2v-.2c0 .2.4.2.5.4h-.3l-.3.1.2.3h-.2c-.1 0-.1-.2-.2-.1a.1.1 0 0 0-.1 0v.2c0 .1.1.2.2.1s0 0 .1 0h.1s0-.1 0 0h.2V15l.2-.1s.2.3.4.3h.2c0 .1 0 0-.1 0a.1.1 0 0 0-.2.2h.2v.2h.1v-.2.1h.1c.1-.1 0-.1 0-.2h.1a.1.1 0 0 0 .1-.1zm-4 2.4l-.2.1.1.1v.7l-.7-1 .7-.2c.1 0 .2.1.1.3zm-.2 1.6l-1-1.4.3-.1.7 1v.5zm-.1.7L25 17.8h.4l1.1 1.7v.4zm-1.7-2.1l1.6 2.3c-.8-.4-1.7-1.1-1.6-2.3zm2.4-.2c0-.3-.2-.5-.5-.5-.2 0-.7.3-1.3.3-.3 0-.7-.1-.9-.3v.2a.2.2 0 0 0-.3-.2.2.2 0 0 0-.1.2.2.2 0 0 0 .2.2v.1c0 1 .7 2.4 2 2.7.2 0 .4 0 .4.2 0 .1 0 .2-.2.2s0 0 0-.1v-.2c-.1 0-.3 0-.3.2a.3.3 0 0 0 .3.3c.2 0 .5-.1.4-.5h.2v-2.6h.2v-.2zm-1.1-4.8v-.1.1zm0-.2v-.1zm.8.4c.4 0 .5 0 .5-.2 0-.3-.8-.1-.8-.3v-.1c.5 0 .5-.4.8-.4-.4 0-.5.2-.6.3l.1-.2-.4.2v.2c0 .3.8 0 .8.3 0 .1 0 .2-.4.2-.1 0-.3-.2-.6 0l.1-.3v-.2h-.3v.5H26v-.4h-.3.1v.1c-.1 0-.1.1 0 .2 0 .1-.2 0-.1 0-.1.1 0 .1 0 .1h.1v.2h-.2s-.2.1-.2 0H25l.2.1H25c0 .1 0 .1 0 0v.1l.1.1v-.1h.8v-.1h.2l.2-.1c.1 0-.1-.2.2-.2l.1.2h.1-.3v.2h.2v-.2h.1c.2 0 0 0 0 0h.2c0 .1 0 0 0 0l-.1.2h.2V13h-.1.1zm-1.6 1.1V14h.1v.1h-.1zm.1-.2h-.1.1zm0 0h.2l-.1.1zm2 .3L27 14h-1c0-.2.2-.2.4-.2.4.2.9 0 1.1 0-.2-.2-.5 0-.8 0l.3-.1h-.6c-.3 0-.5 0-.5.2 0 .3.8.1 1.1.1h.3c0 .2-.3.2-.4.2-.2 0-.9-.2-1.3 0a.3.3 0 0 0 .1-.3v-.2h-.1l-.1-.1h-.2v.1l-.1.2v.2h-.1L25 14v-.3l-.1-.1v.1h-.1s0-.1-.1 0v.2c0 .1 0 .1 0 0-.2.1 0 .2 0 .2h.1l.2.1s0 .1.1 0v.2h-.5c0-.1-.1-.1-.1 0a.1.1 0 0 0-.1.1s0 .1.1 0v.2l.1-.2.1.1h.7l.2-.2c.4 0 .2-.2.6-.2h.1v.2h.1c-.1 0-.1-.1-.2 0a.1.1 0 0 0-.2 0h.1v.1c0 .1.1.2.2.1l.1-.1h.2v-.2h.5v.1H27a.1.1 0 0 0-.1.1h.1v.1h.3l-.1-.1v-.4h-.4.7zM25 15.5v-.2h.1v.2H25zm.1-.3zm0 0h.2v.1h-.1zm2.2.3l-.4-.1h-1.2c0-.2.3-.1.5-.1h1.1c-.2-.2-.5 0-.7 0l.3-.1h-.7l-.6.1c0 .3 1 .2 1.3.2h.3l-.4.1h-1.6s.2-.1.1-.2v-.2H25V15l-.1.1v.4h-.2l-.1-.2v-.2l-.2-.1v.4c0 .2-.1.1 0 0a.1.1 0 0 0 0 .2h.1l.2.2h.1v.2h-.4v-.1h-.2l.2.1-.2-.1H24c0 .1 0 .1.2 0 0 .1-.1.1 0 .1h.8l.1-.1.2-.1c.5 0 .2-.2.7-.2l.1.1c0 .1 0 0-.2 0a.1.1 0 0 0-.1 0h.1c0 .1-.1 0 0 .2l.1.1h.1v-.1h.3v-.2h-.1.7c0 .1 0 0 0 0h-.1a.1.1 0 0 0-.1.2h.1v.1h.1v-.1l.2.1-.1-.2v-.3h-.4.6zm1.9 2c0-.1 0-.1 0 0v-.2.2zm0-.4zm.1 0l.2.1h-.1zm2.2.6l-.1-.1H31l.5-.2-.4-.1h-1.2c0-.2.3-.1.5-.1h1.1c-.3-.1-.5 0-.8 0l.4-.1h-.7l-.6.1c0 .3 1 .2 1.2.2h.3l-.4.1h-1.5s.1-.1 0-.2h.1V17H29v.4h-.2l-.1-.1V17l-.1-.1v.1h-.1v.1c-.1 0-.1 0 0 .1 0 .2-.2.1-.1 0a.1.1 0 0 0 .1.2l.3.2.1.1h-.6l.2.1h-.2a.1.1 0 0 0-.1 0c0 .1 0 .2.2 0 0 .1-.1.2 0 .2h.6l.1-.1h.1v-.1c.6 0 .3-.2.8-.1l.1.1h.1-.2a.1.1 0 0 0-.2 0h.1v.2s0 .1.1 0 0 0 .1 0h.2v-.2h.4c0-.1 0 0 .1 0h-.1a.1.1 0 0 0 0 .1v.1h.3v-.2h.5zm-2.2.9h-.1v-.1.1zm0-.2h-.1zm.8 0v.1c.4.1.8-.2 1 0-.2-.2-.4 0-.7 0l.4-.2h-.6c-.2 0-.4 0-.4.2 0 .3.8.1 1 .1l.2.1-.4.1h-1.2s.1-.2 0-.2h.1v-.2h-.2v-.1h-.1l-.2.1v.4h-.2v-.3h-.2.1v.1c-.1 0-.1 0 0 .1 0 .1-.1 0-.1 0a.1.1 0 0 0 .1.2h.3v.2h-.5c0-.1 0-.1 0 0h-.1s-.1 0 0 .1c0 0 0 .1 0 0v.1l.1.1V19h.4l.1.1.2-.1.1-.1h.1c.3 0 0-.3.5-.2l.1.1h.1-.3a.1.1 0 0 0-.1 0h.1v.5h.2V19h.2v-.2H30h.6c0 .1-.1 0-.1 0a.1.1 0 0 0-.2.2h.2s-.1 0 0 0v.1l.1-.1.1.1v-.3h.1v-.2h-.5l.5-.2-.3-.1h-.9.5zm-1 1.6v-.1H29v-.1h.1v.2zm0-.3H29a.5.5 0 0 1 .1 0zm.1 0v.1zm.7 0c.4.2.8 0 1 0h-.7.3-.6c-.1 0-.3 0-.3.2s1 0 1 .1l-.4.1h-1l.2-.2v-.2H29v.5l-.2-.2v-.3h-.2v.3c-.1 0 0 .1 0 0l.1.1.1.2.2.1h-.2v.1h-.4v.1h-.1s-.1 0 0 0c0 .1 0 .2 0 0v.2h.1v-.1h.5l.1.1.2-.1.1-.3h.3v.2c-.2 0-.2-.2-.3-.1v.4h.3v-.2l-.1-.3h.3l.1.1h-.2v.4l.1-.1h.1v-.2h.1v-.1l-.1-.2.5-.1c0-.3-.9 0-.9-.2l.5-.2zM15 3.7s0-.2-.2-.2-.2.2-.2.2c0 .2 0 .3.2.3.1 0 .2-.1.2-.3zm0-.5c0-.2-.2-.2-.3-.2-.1 0-.2 0-.2.2s0 .2.2.2c.1 0 .2 0 .2-.2zm0-.3c.2 0 .3 0 .3-.2s-.1-.2-.3-.2c0 0-.2 0-.2.2s.1.2.2.2zm.6 0c.1 0 .2-.1.2-.3s0-.2-.2-.2l-.2.2.2.3zm2.6-.4h.3a.2.2 0 0 0 0-.3.2.2 0 0 0-.3 0 .2.2 0 0 0 0 .3zm0-.5a.2.2 0 0 0 0-.3.2.2 0 0 0-.4 0 .2.2 0 0 0 0 .3h.3zm-.7-.1a.2.2 0 0 0 0-.3.2.2 0 0 0-.3 0 .2.2 0 0 0 0 .3h.3zm-.5.3a.2.2 0 0 0 0-.3.2.2 0 0 0-.3 0 .2.2 0 0 0 0 .3.2.2 0 0 0 .3 0zM15.6 2l.2.4.2-.2.1.5c0 .1.1.2.3.2l.2-.2-.1-.3-.3-.3h.4l-.1-.4-.3.2v-.4l-.4.1.3.4z"></path>
              <path d="M18.2 2.6l.1.4-.2-.3v.6l.2-.2c0 .3-.1.5-.3.5 0 0-.2 0-.2-.2 0-.1 0-.3.2-.1 0-.3-.2-.3-.4-.2.2-.3.1-.5-.1-.6-.2.2-.1.5.1.6-.2 0-.4.1-.2.3 0-.2.2-.1.2 0 0 .2 0 .3-.3.4-.3.1-.4 0-.4-.2h.3v-.4l-.4.3.1-.5-.6.3.4.3h-.5l.3.4c0-.3.1-.4.2-.4 0 .2.1.4-.2.5H16c0-.1 0-.3.2-.2 0-.3-.3-.3-.4 0 0-.4 0-.6-.4-.6 0 .3 0 .4.3.6-.1 0-.3.1 0 .3 0-.1 0-.2.2 0l-.1.3c-.1 0-.3 0-.5-.2h.2l-.3-.4v.3l-.1-.3-.3.2.9.8 1.3-.6a9.4 9.4 0 0 1 1.5-.5V2.6zm.7 3c-.3.3-.7 0-1-.3l1.3-.6c-.3.5 0 .7-.3.9zm-.1 3.2c-.4.2-.7-.2-.8-.4V8c.1-.2.2-.3 0-.5 0-.3-.3-.2-.6 0 .2-.3.2-.5 0-.5s-.2.4-.4.3V7c0-.2 0-.2.2-.3l1.2-.4h.3s.3.1.2.2c0 .2-.3-.1-.5 0 0 .1 0 .3.3.3-.3.2-.6.3-.5.5.1.2.2.3.5.3l.3.4c.2.3.2.7-.2 1zm-2.2-2.3c-.3 0-.3-.3-.9-.4l1.4-.5c0 .4-.1.8-.5.9zM23 16.8c0-.2-.4-.5-.4-.8 0-.4 0-.7-.4-1.1l-2.1-2.4s.3 0 .5.2l.7.7A7 7 0 0 1 23 11l.2-.3-.8.3c0-.4 0-.7-.2-1 0-.5 0-1.2-1.2-2 .6.1 1 .7 1.4.3-.4 0-.4-1-2-1.7.6 0 1.1.9 1.8.4-.7-.1-.9-1.3-2-1.6.4 0 .8.2 1.1-.3-.4.1-.6-.2-1-.3V3.7a1.4 1.4 0 0 0-1 .4c0-.3-.2-.4-.5-.3V4l-1.5.4-1.3.7c-.1.1-.2 0-.3-.1-.2.1-.3.3-.2.5a2 2 0 0 0-1 .3c0 .4.4.7.8 1-.7.6-.1 1.3-.7 2 .9 0 .7-1.3 1.2-1.5 0 1-.6 1-.6 2 0 .5.3 1 0 1.4.8-.2.6-1.9 1-2.3.2.2.1.5 0 .8-.2.7 0 1.8-.4 2.2.8-.1.9-1.3 1.5-1.8-.5 1.1-1 3.4-1.8 4.6-1.3 1.8-2.1 3.9-3.3 3.9-.5 0-1-.3-1-1 0-2 3.5-3.3 3.5-5.4 0-1-.8-1.4-1.3-1.4a2 2 0 0 0-1 .5l-.4-.1c-1.2 0-1 2.2-2 2.2.4.2 1.2-.3 1.6-.9-.2 1.4-2.2 1-2 2.8.2-1.4 3.5-1.2 3.5-3.2l-.3-.6.7-.2c.4 0 .7.3.7.9 0 1.7-3.4 3.2-3.4 5.4 0 .4.1.7.3 1-.2 0-.5 0-.7-.2 0 .6.8 1 1.3.6h.3c-.1.5-.7.6-1 .6 1 .7 2.4-.2 2.3-1 .7-.4 1-1.4 1.5-2v.5c-.5.8-1 1.6-1.1 2.8-.1 1-.6 1.8-1.3 1.8h-.5c-.2.1 0 .3 0 .5 0 .3-.6.6-.6 1.4 0 .4.3.9.2 1.1.2-.1.5-.5.6-1 .2 1.2-.5 1.2 0 2.1 0-.3.4-.5.7-.3s0 .2 0 .4c-.2.1-.4.9.3.8-.1 0-.1-.3.2-.3h1.1c.3 0 .4-.3.7-.3s.3.2.2.3c.4 0 .5-.3.5-.5s-.2-.3 0-.4c0-.1.5 0 .3.4.2 0 .4-.2.4-.5s-.4-.5-.7-.4c0-.2-.3-.3-.6-.3-.5 0-.5.5-.8.5-.6 0-1.2-.8-1.2-2.1 0-.8.8-1 1.3-1.2.6-.2 1.5-.8 2.1-1.8.4-.7.5-1.5.4-2.5.7.4.8 1 .8 1.5 0 .6-.3.9-.5 1-.3 0-.3 0-.3.2l.1.3c.3.1.2.4.3.7.1.3.4.7.8 1V21c.6.3.1 1.5 1.3 1.5-.3-.1-.2-.4 0-.5l.4.4c.2.3.2.3.7.3.5 0 .3-.2.6-.2s.2.4.1.6c.5-.2.6-.5.5-.9.4-.2.7 0 .7.3.5-.4 0-1-.3-1 0-.1-.2-.3-.4-.3h-.5c-.2 0-.3.3-.5.3-.7 0-2.2-1.3-2.2-1.9 0-.5 1.4-.9 1.4-1.7 0-1.2-1.1-1.6-2-2.3.3-.4 1.2-.5 1.8-.1 0-.4.3-.3.4-.8.2.4 0 .8.1 1 .2-.2.6-.2.6-.7.1.3-.2.9.1 1.2 0-.3.2-.4.4-.4s.2.1.2.3c0 .4-.6.2-.6.7 0 .2.3.3.3.5 0 .1-.2.3-.5.1l.5.1c.2 0 .5-.2.6-.4.1.3 0 .7-.2.7.2.2.8 0 .7-.7.4 0 .6.3.3.7.3-.1.6-.2.6-.5s-.3-.3-.1-.6zm22 5.5c0-.4.2-.8.6-.8.4 0 .8.4.8.8a.7.7 0 0 1-.8.7.7.7 0 0 1-.7-.7zm-.3 0c0 .5.5 1 1 1s1-.5 1-1a1 1 0 0 0-1.7-.7 1 1 0 0 0-.3.7zM41.6 24a.4.4 0 0 1-.4-.4l.1-.2.5-.1c.2 0 .4.2.4.4s-.2.4-.6.3zm-.4-.9l-.2.4a.5.5 0 0 0 .2.5l.4.2h.6a.6.6 0 0 0 .3-.4c0-.4-.2-.7-.6-.8l-.7.1zM36 10.3l.2-.4a.6.6 0 0 1 .4-.1h.2a.4.4 0 0 1 0 .3c0 .1 0 .2-.2.3H36v-.1zm0-.6c-.3.2-.3.6-.1.9.2.2.5.2.9 0a.8.8 0 0 0 .3-.5l-.1-.4-.4-.1-.5.1zm4.6 13a.3.3 0 0 1-.3-.1l-.1-.4c0-.2 0-.3.2-.4a.3.3 0 0 1 .2-.1c.2 0 .3.2.3.5l-.1.4h-.2zm-.4-1.2a.8.8 0 0 0-.2.6c0 .2 0 .5.2.6l.4.2a.5.5 0 0 0 .4-.2.8.8 0 0 0 .2-.6c0-.2 0-.4-.2-.5l-.4-.2-.4.1zm-4.5-6.7c-.3-.2-.4-.4-.3-.6l.2-.1a.5.5 0 0 1 .4 0l.3.3v.2l-.2.2h-.4zm-.2-1l-.3.3c-.1.3 0 .7.4.8.2.1.5.2.6 0 .2 0 .3 0 .3-.2 0-.1.1-.2 0-.4 0-.2-.2-.4-.4-.5a.9.9 0 0 0-.6 0z"></path>
              <path d="M42.3 18.2c-.1.2-.4.3-.6.1v-.6c.2-.2.4-.3.6-.2.2.2.2.4 0 .7zm-1 1.8c-.2.2-.5.3-.7.1v-.6c.2-.2.4-.3.6-.2.2.2.2.4 0 .7zm-4-9.8l.5-1.3.4.2-.4.3a.4.4 0 0 0 .4 0l-.2.4a.8.8 0 0 0-.2-.2c-.1.3 0 .4.3.5.2.2.4.2.5 0 0 0 0-.3-.3-.2 0-.2 0-.3.3-.3 0 0 .2 0 .2.2 0-.3.2-.6.5-.7.1.3 0 .6-.3.9h.4l-.1.4c0-.2-.3-.3-.4 0l.2.4c.3.1.6 0 .7-.2h-.4l.3-.5c0 .1 0 .3.2.3V10l.6.4-.4.2h.3l-.4.5-.1-.4c-.2.3-.1.5.2.7.2.1.4.2.5 0 0-.1 0-.4-.3-.3 0-.2.1-.3.2-.3.2 0 .3.1.3.3 0-.4.2-.6.6-.7 0 .4-.1.6-.4.8h.3c.1.2 0 .4-.1.5 0-.2-.4-.3-.4-.1-.1 0 0 .2.3.4.1 0 .3.2.6 0a.6.6 0 0 0-.4-.2l.3-.3.2.3v-.5l.4.3-.9 1zm4.7 5.3l.1-.2.2-.1c.2 0 .3 0 .4.2l.2.4v.2h-.7l-.2-.5zm1.8 7.9a.7.7 0 0 1 .2-.4h.7a.5.5 0 0 1 0 .3.7.7 0 0 1-.2.4h-.7v-.3zm-8.2-11.9a.5.5 0 0 1-.1.4h-.2c-.2 0-.3-.1-.3-.4a.5.5 0 0 1 .2-.4h.3a.8.8 0 0 1 .1.4zm2.5-5.2c.1-.2 0-.6.5-.6l.7.3c-.4 0-.9.1-1.2.3zm7.4 6.5c.3.9 1 1.2 1.4 1-1-.2-.2-2-1.6-2h-.2c-.2-.2-.5-.3-.9-.3-.5 0-1.5.6-1.5 1.7 0 2.5 2.8 2.7 2.8 5 0 .6-.5 1-1 1s-.9-.6-1.3-1.4c-.1-.4-.6-1-1-1.6.1.1.3.2.4.1h.4a.6.6 0 0 0 .2-.5l-.2-.6a1 1 0 0 0-.7-.2l-.3.1a.6.6 0 0 0-.2.4v.3c-.6-.8-1.2-1.6-1.2-2 0-.4.3-.8.6-1.2h.2l.9-1 .1-.1-.3-.3.2-.6c.1.4.4.6.6.5-.2-.3.2-1 0-2 .2.5.6.6.8.6-.6-.6.2-1.4-.6-2.6h.5C43 7 43.2 6 42 5.6c.3 0 .5-.2.5-.4-.4.3-.7-.5-1.8-.4-.1-.5-.5-1-1-1.1.1.3 0 .6 0 .8L35.8 1l-.2-.1V1L39 5l-.8.3c-.2 0-.3.2-.3.4a7.4 7.4 0 0 0-1.3.9c-.2.1-.4.2-.2.6 0 .1-.1.5.3.2.3-.1 1-.5 1.1-.3 0 .2-.3.3-.5.4l-.5.4h.3l.1.3c.1 0 .3-.2.4-.1 0 0 0 .5-.2.6.4 0 .6-.4.6-.7l.2-.4v.5c.2 0 .4-.3.4-.7l.2-.2c.2 0 .4.4.7.4.7 0 1-.5 1-.8a.7.7 0 0 0 0-.5c.2.2.3.5.3.7 0 .9-1.6 1.3-2.3 2l-.8-.3V9l-.1.1c0 .3-.2.8-.4 1.1v.2c-.4.6-.7 1.2-.8 2a5 5 0 0 0-.5-.5v-.3c0-.2 0-.3-.2-.5l-.3-.2a.5.5 0 0 0-.4.2h-.1l-.7-.6a.4.4 0 0 0-.4-.1h-.3l-.3.1-.5.4.3.3.1.2.2-.1c.1-.2.2-.2.3-.2l.3.2 1.2 1.5H34c-.2 0-.2 0-.4.3l-.2.2v.5c.3.3.8 1.3 1 1.8.2.4.4.5.8.6l1 .6v-.3l-.5-.3c-.2 0-.2-.1 0-.1l.8.3c0-.4-.4-.7-.6-1h-.6l-.1.2c-.1 0-.2 0-.2-.2 0 0 .2-.1.2-.3s-.3-.2-.5-.2l-.5-1c-.2 0 0-.2 0-.3.2-.1.6.1 1.3.2h1c0 .9.4 1.7 1.6 2a2 2 0 0 1 1.5 1.2c-2.5 0-2.9.9-2.9 1.8 0 1 .9 1 .9 1.7s-2 1-2.7 1.1c-.5 0-.8.2-1.1.4l-1 1h.4l.4-.4.2-.2v.3l-.3.4c1.2.1 1.3-.3 1.3-.5s-.3-.3-.2-.5c.2-.1.3 0 .5.2s.2.3.5.1l3-1.2c.3-.1.2-.3 0-.4l-.2-.7c0-.8.5-1 1.4-1v.4c0 1.2 1.8 2.5 2.3 2.5.2 0 .5-.2.6.5 0 .6.1 1 0 1.6 0 .7-.3.8-.6 1s-.8 1.1-1 1.3c.2.1.4.1.5-.3l.4-.6-.3 1c.5.2 1.3-.3 1.3-.6 0-.4-.3-.3-.3-.5 0-.1.1-.3.3-.3.2 0 .3.2.3.3.2-.2.4-.4.4-.9v-.6c.1.2.3.3.5.3h.5a.9.9 0 0 0 .3-.6v-.1a.8.8 0 0 0 0-.4l-.4-.2a.8.8 0 0 0-.6.2c-.2 0-.3.2-.4.4a37 37 0 0 1 0-1.5l-.1-.7-.5.2c-.2 0-.7-.5-.7-1 0-.6.5-1.3.5-2 0-.2.2-.4.3-.2l.5 1c-.2.9.9 1.8 1.7 1-.4.1-.7-.2-.9-.6h.4c.3.4 1.2.4 1.4-.6-.1.2-.4.4-.7.3.3-.2.5-.7.5-1.1 0-2.4-2.8-2.7-2.8-4.8 0-.8.7-1.3 1.1-1.3l.5.1c-.2.2-.3.5-.3.8.1 1.7 2.8 1.7 2.9 2.5.3-1.4-1.7-1-1.8-2.7z"></path>
            </svg>
            <span class="ccs-logo__text" hidden="hidden">
              Crown Commercial Service
            </span>
          </span>
        '.to_one_line)
      end
    end
  end
end
