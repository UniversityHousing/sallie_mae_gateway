class SallieMaeController < ApplicationController
  def cancel
    render :action => 'process_payment'
  end
end