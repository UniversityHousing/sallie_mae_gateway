module SallieMaeGateway
  class Payment
    CHECKING, CREDIT_CARD, DEBIT_CARD, SAVINGS = 'A', 'C', 'D', 'S'
    
    attr_accessor :student, :line_items
    attr_accessor :school_id, :postback_url, :finish_url, :cancel_url, :user_def1, :user_def2, :allow_edit, :payment_type
    
    def initialize(args={})
      if args.is_a? Hash
        args[:allow_edit] ||= false 
        args[:payment_type] ||= CREDIT_CARD
        args.each { |key, value|
          instance_variable_set "@#{key}", value
        }
      end
      @line_items ||= []
    end

    def school_id
      @school_id || SALLIE_MAE_CONFIG['school_id']
    end

    def postback_url
      @postback_url || SALLIE_MAE_CONFIG['postback_url']
    end

    def cancel_url
      @cancel_url || SALLIE_MAE_CONFIG['cancel_url'] 
    end

    def finish_url
      @finish_url || SALLIE_MAE_CONFIG['finish_url']
    end
    
    def total_amount
      @line_items.reduce(0.0) { |sum, item| sum += item.amount }
    end
  end
end