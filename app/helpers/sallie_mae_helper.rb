module SallieMaeHelper
  def sallie_mae_form(payment,options={})
    options[:button_label] ||= "Make a Payment"
    render 'sallie_mae/hidden_form_with_button', payment: payment, options: options
  end
end