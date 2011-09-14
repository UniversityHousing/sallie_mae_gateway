SallieMae Electronic Payment Gateway SSO
===

A simple collection of models and helpers that speeds up the implementation of SallieMae EPG SSO within a **Rails 3.1.x** application.

Installation
===
In your _Gemfile_ add the following line

    gem 'sallie_mae_gateway', '~> 0.0.1'

Configuration
===
You must create a YAML configuration file in your _config_ directory with the filename _salliemae.yml_. An example is included in the gem _config_ directory and is a good starting point.

    $ cat config/salliemae.yml
    
    default: &default
      url: 'https://stg.bosebill.salliemae.com/NetPay/Products/Gateway.aspx'
      product_id: "0000"
      school_id: "123456789"
      postback_url: 'http://localhost:3000/sallie_mae/process'
      finish_url: 'http://localhost:3000/sallie_mae/process'
      cancel_url: 'http://localhost:3000/sallie_mae/cancel'
    development:
      <<: *default
    test:
      <<: *default
    production:
      <<: *default

Example Usage
===
You'll use these models to create the payment object within your controller and to process the response from SallieMae. There are a couple of helpers to speed up creating your payment form within your views. That's it!
This gem makes no assumptions about your payment processing system and does not contain any controllers to handle the creation or handling of responses.

Controller - New Payment
---
Start in your controller by instantiating a _SallieMaeGateway::Student_ and at least one _SallieMaeGateway::LineItem_ objects. Then create a _SallieMaeGateway::Payment_ object providing your _student_ and *line_items*.

    $ cat app/controllers/payment_controller.rb
    .
    .
    .
    def new
      student = Student.find(123)
      student_for_payment = SallieMaeGateway::Student.new(account: student.id, first_name: student.first_name, last_name: student.last_name, email: student.email )
      line_items = [
        SalieMaeGateway::LineItem.new(type: "AF", description: "Application Fee", amount: 75.00),
        SalieMaeGateway::LineItem.new(type: "SCD", description: "Student Card Deposit", amount: 150.00)
      ]
      @payment = SallieMaeGateway::Payment.new(student: student_for_payment, line_items: line_items)
    end
    .
    .
    .
View
---
In the view you can use the provided helpers to generate a simple button that can be clicked to take them to the payment gateway or you can display a read only form with more details

    $ cat app/views/payment/new.html.erb
    
    # This helper displays the button
    <%= sallie_mae_button @payment %>
    
    # This helper displays the read-only form
    <%= sallie_mae_form @payment %>
Controller - Process Response
---
You'll need to pass the response provided by SallieMae to the _SallieMaeGateway::Response_ object. You can then access the details from that instance, passing it to a model in your application or doing additional processing on .

    $ cat app/controllers/payment_controller.rb
    .
    .
    .
    def process
      @sallie_mae_response = SallieMaeResponse::Response.new(params)
      # Use this object to access the response data, for example:
      transaction = Transaction.new
      transaction.transaction_id = @sallie_mae_response.transaction_id
      transaction.amount = @sallie_mae_response.amount_paid
      transaction.save
    end
    .
    .
    .



Tests
===
Tests are written using Steak and RSpec 2 and are included in the _spec_ directory.

This project uses MIT-LICENSE.