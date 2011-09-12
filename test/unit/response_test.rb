class ResponseTest < ActiveSupport::TestCase
  def setup
    @success_params = {"SCHOOL_ID"=>"00175800", "USR_DEF1"=>"", "USR_DEF2"=>"", "STUDENT_UID"=>"", "STUDENT_SUFFIX"=>"", "EDIT_INDICATOR"=>"", "PWP"=>"", "ALT_OTPSSO_URL"=>"http://localhost:3000/sallie_mae/process", "FINISH_URL"=>"http://localhost:3000/sallie_mae/process", "CANCEL_URL"=>"http://localhost:3000/sallie_mae/cancel", "BUSINESS_ABBREVIATION"=>"UNIV", "SCHOOL_EMAIL"=>"", "PRODUCT_ID"=>"1396", "TIMESTAMP"=>"20110912095504", "TRANSACTION_ID"=>"11951020110912", "PMT_TYPE"=>"100", "PMT_TYPE_DESC"=>"Dinig Plan", "AMOUNT_PAID"=>"170.00", "AUTH_CODE"=>"202221212", "SUCCESS_INDICATOR"=>"A", "PMT_INDICATOR"=>"MC", "ACCOUNT"=>"850000000", "STUDENT_LASTNAME"=>"Doe", "STUDENT_FIRSTNAME"=>"John", "STUDENT_MNAME"=>"", "STUDENT_FULLNAME"=>"", "STUDENT_DOB"=>"", "CONSUMER_EMAIL"=>"student@university.edu", "TRANSACTION_EFFECTIVEDATE"=>"9/12/2011", "CONSUMER_NAME"=>"John Q Doe", "CONSUMER_ADDRESS"=>"123 State Street", "CONSUMER_CITY"=>"Carbondale", "CONSUMER_ZIP"=>"62901", "CONSUMER_STATE"=>"ILLINOIS", "STUDENT_EMAIL_1"=>"student@university.edu"}
    @successful_response = SallieMaeGateway::Response.new(@success_params)
    
    @canceled_params = @success_params
    @canceled_params["SUCCESS_INDICATOR"] = 'C'
    @canceled_response = SallieMaeGateway::Response.new(@canceled_params)
  end
  
  test "a TypeError is raise if the response is not provided" do
    assert_raise(TypeError) { 
      sm_response = SallieMaeGateway::Response.new
      sm_response.raw_response = nil
    }
  end
  
  test "a raw response is processed and instance variables are created automagically" do
    assert_equal @success_params["SCHOOL_ID"], @successful_response.school_id
    assert_equal @success_params["TRANSACTION_ID"], @successful_response.transaction_id
    assert_equal @success_params["AMOUNT_PAID"], @successful_response.amount_paid
  end
  
  test "#canceled? should return false for a successful payment" do
    assert_equal false, @successful_response.canceled?
  end
  
  test "#success? should return true for a successful payment" do
    assert @successful_response.success?
  end
  
  test "#canceled? should return true for a canceled payment" do
    assert @canceled_response.canceled?
  end
  
  test "#success? should return false for a canceled payment" do
    assert_equal false, @canceled_response.success?
  end
  
  test "#payment_method should return 'Master Card' for successful payment with 'MC'" do
    assert_equal SallieMaeGateway::Response::PAYMENT_INDICATOR['MC'], @successful_response.payment_method
  end
  
  test "#success_message returns 'Credit Card Accepted' for successful payment" do
    assert_equal SallieMaeGateway::Response::SUCCESS_INDICATOR['A'], @successful_response.success_message
  end
  
end