class LineItemTest < ActiveSupport::TestCase
  def setup
    @line_item = SallieMaeGateway::LineItem.new(
      type: "HPRH",
      description: "Contract Prepayment",
      amount: 350.00
    )
  end
  
  test "payment should be the right kind of object" do
    assert_instance_of(SallieMaeGateway::LineItem, @line_item)
  end
  
  test "sets instance variables correctly" do
    assert_equal("HPRH", @line_item.type)
    assert_equal("Contract Prepayment", @line_item.description)
    assert_equal(350.00, @line_item.amount)
  end
end