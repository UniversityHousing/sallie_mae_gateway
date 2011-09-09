module SallieMaeGateway
  class Railtie < ::Rails::Railtie
    puts ::Rails.root
    def self.root
      ::Rails.root
    end
  end
end