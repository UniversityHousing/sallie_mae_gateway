module SallieMaeGateway
  class Student
    attr_accessor :account, :email, :first_name, :last_name
    
    def initialize(args)
      args.each { |key, value|
        instance_variable_set "@#{key}", value
      } if args.is_a? Hash
    end   
  end
end