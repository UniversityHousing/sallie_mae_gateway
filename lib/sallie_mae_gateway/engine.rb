require 'sallie_mae_gateway'
require 'rails'

module SallieMaeGateway
  class Engine < Rails::Engine
    config.to_prepare do
      ActionView::Base.send(:include, SallieMaeHelper)
    end
  end
end
