class PaymentTest < ActiveSupport::TestCase
  def setup
    @payment = SallieMaeGateway::Payment.new(
      school_id: SALLIE_MAE_CONFIG["school_id"],
      postback_url: SALLIE_MAE_CONFIG["postback_url"],
      cancel_url: SALLIE_MAE_CONFIG["cancel_url"],
      finish_url: SALLIE_MAE_CONFIG["finish_url"]
    )
    @line_item_one = SallieMaeGateway::LineItem.new(
      type: "HPRH",
      description: "Contract Prepayment",
      amount: 350.00
    )
    @line_item_two = SallieMaeGateway::LineItem.new(
      type: "HDBM",
      description: "Dining Plan",
      amount: 170.00
    )
  end
  
  test "payment should be the right kind of object" do
    assert_instance_of(SallieMaeGateway::Payment, @payment)
  end
  
  test "sets instance variables correctly" do
    assert_equal(SALLIE_MAE_CONFIG["school_id"], @payment.school_id)
    assert_equal(SALLIE_MAE_CONFIG["postback_url"], @payment.postback_url)
    assert_equal(SALLIE_MAE_CONFIG["cancel_url"], @payment.cancel_url)
    assert_equal(SALLIE_MAE_CONFIG["finish_url"], @payment.finish_url)
    assert_instance_of Array, @payment.line_items
  end
  
  test "allows line items to be added via #line_items" do
    @payment.line_items << @line_item_one
    @payment.line_items << @line_item_two
    assert_instance_of Array, @payment.line_items
    assert_equal 2, @payment.line_items.size
  end
end