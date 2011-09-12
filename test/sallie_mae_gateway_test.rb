require 'test_helper'

class SallieMaeGatewayTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, SallieMaeGateway
  end
  
  test "initial configuration" do
    assert_kind_of Hash, SALLIE_MAE_CONFIG
    assert SALLIE_MAE_CONFIG.include?("url")
  end
end
