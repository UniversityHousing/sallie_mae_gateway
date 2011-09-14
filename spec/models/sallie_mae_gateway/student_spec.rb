require 'spec_helper'

describe SallieMaeGateway::Student do
  
  subject do
    SallieMaeGateway::Student.new(
      account: "850000000",
      email: "nobody@localhost",
      first_name: "John",
      last_name: "Doe"
    )
  end
  
  context "#initalization" do
    its(:class) { should == SallieMaeGateway::Student }
    its(:account) { should == "850000000" }
    its(:first_name) { should == "John" }
    its(:last_name) { should == "Doe" }
  end
  
  
end