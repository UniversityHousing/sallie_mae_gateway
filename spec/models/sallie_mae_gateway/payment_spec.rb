require 'spec_helper'

describe SallieMaeGateway::Payment do
  
  subject do
    SallieMaeGateway::Payment.new(
      school_id: SALLIE_MAE_CONFIG["school_id"],
      postback_url: SALLIE_MAE_CONFIG["postback_url"],
      cancel_url: SALLIE_MAE_CONFIG["cancel_url"],
      finish_url: SALLIE_MAE_CONFIG["finish_url"]
    )
  end
  
  let(:line_item_one) { SallieMaeGateway::LineItem.new(type: "HPRH", description: "Contract Prepayment", amount: 350.00) }
  let(:line_item_two) { SallieMaeGateway::LineItem.new(type: "HPDP", description: "Dining Plan", amount: 170.00) }
  
  context "#initalization" do
    its(:class) { should == SallieMaeGateway::Payment }
    its(:school_id) { should == SALLIE_MAE_CONFIG['school_id'] }
    its(:postback_url) { should == SALLIE_MAE_CONFIG['postback_url'] }   
    its(:cancel_url) { should == SALLIE_MAE_CONFIG['cancel_url'] }   
    its(:finish_url) { should == SALLIE_MAE_CONFIG['finish_url'] }
    its(:line_items) { should be_a(Array) }
    specify { subject.line_items.size.should == 0 }    
  end
  
  context "#line_items" do
    context "one line item is provided" do
      before(:each) do 
        subject.line_items << line_item_one
      end
      specify { subject.line_items.size.should == 1 }
      its(:total_amount) { should == line_item_one.amount }
    end
    context "multiple line items are provided" do
      before(:each) do
        subject.line_items << line_item_one
        subject.line_items << line_item_two
      end
      specify { subject.line_items.size.should == 2 }
      its(:total_amount) { should == (line_item_one.amount + line_item_two.amount) }
    end
  end
  
end