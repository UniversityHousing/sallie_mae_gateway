require 'spec_helper'

describe SallieMaeGateway::LineItem do
  
  subject do
    SallieMaeGateway::LineItem.new(
      type: "HPRH",
      description: "Contract Prepayment",
      amount: 350.00
    )
  end
  
  context "#initalization" do
    its(:class) { should == SallieMaeGateway::LineItem }
    its(:type) { should == "HPRH" }
    its(:description) { should == "Contract Prepayment" }
    its(:amount) { should == 350.00 }
  end
  
  
end