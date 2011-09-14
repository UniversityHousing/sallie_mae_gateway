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

This gem makes no assumptions about your payment processing system and does not contain any controllers.

Tests
===
Unit & Helper tests are included in the the _spec_ directory

This project uses MIT-LICENSE.