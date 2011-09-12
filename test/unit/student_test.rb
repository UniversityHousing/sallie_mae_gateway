class StudentTest < ActiveSupport::TestCase
  def setup
    @student = SallieMaeGateway::Student.new(
      account: "850000000",
      email: "nobody@localhost",
      first_name: "John",
      last_name: "Doe"
    )
  end
  
  test "payment should be the right kind of object" do
    assert_instance_of(SallieMaeGateway::Student, @student)
  end
  
  test "sets instance variables correctly" do
    assert_equal("850000000", @student.account)
    assert_equal("nobody@localhost", @student.email)
    assert_equal("John", @student.first_name)
    assert_equal("Doe", @student.last_name)
  end
end