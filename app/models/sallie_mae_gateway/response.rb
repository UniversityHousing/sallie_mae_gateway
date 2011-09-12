module SallieMaeGateway
  class Response
    SUCCESS_INDICATOR = {
      'A' => 'Credit Card Accepted',
      'S' => 'ACH Scheduled',
      'D' => 'Declined',
      'P' => 'Pending',
      'C' => 'Canceled'
    }.freeze
    
    CANCELED, PENDING, SUCCESS = 'C', 'P', 'A'
    
    
    attr_reader :raw_response
    
    def initialize(args=nil)
      if args.is_a? Hash
        @raw_response = args 
        process_response
      end      
    end
    
    def raw_response=(response)
      @raw_response = response
      process_response
    end
    
    def canceled?
      raise 'Unable to determine status. Has a response been provided?' unless self.respond_to? :success_indicator
      self.success_indicator.eql? CANCELED
    end
    
    def success?
      raise 'Unable to determine status. Has a response been provided?' unless self.respond_to? :success_indicator
      self.success_indicator.eql? SUCCESS
    end
    
    def success_message
      raise 'Unable to determine status. Has a response been provided?' unless self.respond_to? :success_indicator
      SUCCESS_INDICATOR[self.success_indicator]
    end
    
    private
    def process_response
      raise TypeError, "Unable to locate the raw response from SallieMae. Has it been provided?" if @raw_response.nil?
      @raw_response.each_pair do |key, value|
        key = key.downcase
        unless self.respond_to? key
          class_eval do
            define_method key do
              self.instance_variable_get "@#{key}"
            end
            define_method "#{key}=" do |new_value|
              self.instance_variable_set "@#{key}", new_value
            end
          end
        end
        self.send "#{key}=", value
      end
    end
  end
end