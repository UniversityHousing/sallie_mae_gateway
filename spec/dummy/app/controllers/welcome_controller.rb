class WelcomeController < ApplicationController
  before_filter :create_payment_object
  
  private
  def create_payment_object
    student = SallieMaeGateway::Student.new(account: "850061633", first_name: "John", last_name: "Doe", email: "dreedy@housing.siu.edu")
    line_item_one = SallieMaeGateway::LineItem.new(type: "HPRH", description: "Housing Contract Prepayment", amount: 350.00)
    line_item_two = SallieMaeGateway::LineItem.new(type: "HDDP", description: "Debit Dawg", amount: 50.00)
    @payment = SallieMaeGateway::Payment.new(student: student, line_items: [line_item_one])
  end
end