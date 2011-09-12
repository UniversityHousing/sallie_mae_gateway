module SallieMaeGateway
  class Payment
    attr_accessor :student, :line_items
    attr_accessor :school_id, :postback_url, :finish_url, :cancel_url, :user_def1, :user_def2, :allow_edit
    
    def initialize(args)
      if args.is_a? Hash
        args[:allow_edit] ||= false 
        args.each { |key, value|
          instance_variable_set "@#{key}", value
        }
      end
      @line_items ||= []
    end
  end
end