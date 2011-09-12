module SallieMaeGateway
  class LineItem
    attr_accessor :type, :description, :amount
    
    def initialize(args)
      args.each { |key, value|
        instance_variable_set "@#{key}", value
      } if args.is_a? Hash
    end   
  end
end