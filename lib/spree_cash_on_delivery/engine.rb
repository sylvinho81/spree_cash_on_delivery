module SpreeCash0nDelivery
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace SpreeCash0nDelivery
    engine_name 'spree_cash_on_delivery'

    config.autoload_paths += %W(#{config.root}/lib)


    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end

    end

    initializer "spree.register.payment_methods" do |app|
      app.config.spree.payment_methods += [
          Spree::PaymentMethod::CashOnDelivery
      ]
    end

    config.to_prepare &method(:activate).to_proc

  end
end