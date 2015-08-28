$LOAD_PATH.unshift("#{__dir__}/../../spec", "#{__dir__}/../../lib")

# require 'page_magic'
# require 'rspec'
# require 'support/pages/login_page'
# require 'support/pages/bill_page'
# require 'billing_service'
# require 'json'

World(
    Module.new do
      def browser
        $browser ||= begin
          PageMagic.session(browser: :firefox).tap do |session|
            session.define_page_mappings '/login' => LoginPage, '/bill' => BillPage
          end
        end
      end

      def application_url(subdomain = '')
        "http://localhost:#{ENV['port'] || 9292}#{subdomain}"
      end

      def page_class(page)
        eval("#{page.capitalize}Page")
      end

      def page_url(page)
        application_url + browser.transitions.key(page_class(page))
      end

      def current_page
        browser.current_page
      end
    end)