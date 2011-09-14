require 'spec_helper'

describe SallieMaeGateway::Response do
  before { @response = SallieMaeGateway::Response.new(raw_response)}
  subject { @response }

  context "Successful Response" do
    let(:raw_response) { {"SCHOOL_ID"=>"00175800", "USR_DEF1"=>"", "USR_DEF2"=>"", "STUDENT_UID"=>"", "STUDENT_SUFFIX"=>"", "EDIT_INDICATOR"=>"", "PWP"=>"", "ALT_OTPSSO_URL"=>"http://localhost:3000/sallie_mae/process", "FINISH_URL"=>"http://localhost:3000/sallie_mae/process", "CANCEL_URL"=>"http://localhost:3000/sallie_mae/cancel", "BUSINESS_ABBREVIATION"=>"UNIV", "SCHOOL_EMAIL"=>"", "PRODUCT_ID"=>"1396", "TIMESTAMP"=>"20110912095504", "TRANSACTION_ID"=>"11951020110912", "PMT_TYPE"=>"100", "PMT_TYPE_DESC"=>"Dinig Plan", "AMOUNT_PAID"=>"170.00", "AUTH_CODE"=>"202221212", "SUCCESS_INDICATOR"=>"A", "PMT_INDICATOR"=>"MC", "ACCOUNT"=>"850000000", "STUDENT_LASTNAME"=>"Doe", "STUDENT_FIRSTNAME"=>"John", "STUDENT_MNAME"=>"", "STUDENT_FULLNAME"=>"", "STUDENT_DOB"=>"", "CONSUMER_EMAIL"=>"student@university.edu", "TRANSACTION_EFFECTIVEDATE"=>"9/12/2011", "CONSUMER_NAME"=>"John Q Doe", "CONSUMER_ADDRESS"=>"123 State Street", "CONSUMER_CITY"=>"Carbondale", "CONSUMER_ZIP"=>"62901", "CONSUMER_STATE"=>"ILLINOIS", "STUDENT_EMAIL_1"=>"student@university.edu"} }
    
    its(:transaction_id) { should == raw_response["TRANSACTION_ID"] }
    its(:amount_paid) { should == raw_response["AMOUNT_PAID"] }
    its(:success_indicator) { should == SallieMaeGateway::Response::SUCCESS }
    its(:payment_method) { should == SallieMaeGateway::Response::PAYMENT_INDICATOR[raw_response['PMT_INDICATOR']] }
    its(:success_message) { should == SallieMaeGateway::Response::SUCCESS_INDICATOR[raw_response['SUCCESS_INDICATOR']] }
    it { should be_success }
    it { should_not be_canceled }
  end
  
  context "Canceled Response" do
    let(:raw_response) { {"SCHOOL_ID"=>"00175800", "USR_DEF1"=>"", "USR_DEF2"=>"", "STUDENT_UID"=>"", "STUDENT_SUFFIX"=>"", "EDIT_INDICATOR"=>"N", "PWP"=>"", "ALT_OTPSSO_URL"=>"http://localhost:3000/sallie_mae/process_payment", "FINISH_URL"=>"http://localhost:3000/sallie_mae/process_payment", "CANCEL_URL"=>"http://localhost:3000/sallie_mae/cancel", "BUSINESS_ABBREVIATION"=>"UNIV", "SCHOOL_EMAIL"=>"", "PRODUCT_ID"=>"1396", "TIMESTAMP"=>"20110914124133", "ACCOUNT"=>"850000000", "STUDENT_FIRSTNAME"=>"John", "STUDENT_LASTNAME"=>"Doe", "CONSUMER_NAME"=>"", "CONSUMER_ADDRESS"=>"", "CONSUMER_CITY"=>"", "CONSUMER_STATE"=>"", "CONSUMER_ZIP"=>"", "PMT_TYPE"=>"HPRH", "SUCCESS_INDICATOR"=>"C", "STUDENT_EMAIL_1"=>"jdoe@university.edu", "PMT_TYPE_DESC"=>"Housing Contract Prepayment", "AMOUNT_PAID"=>"350.00" } }
    
    its(:success_indicator) { should == SallieMaeGateway::Response::CANCELED }
    its(:success_message) { should == SallieMaeGateway::Response::SUCCESS_INDICATOR[raw_response['SUCCESS_INDICATOR']] }
    it { should be_canceled }
    it { should_not be_success }
  end
  
end