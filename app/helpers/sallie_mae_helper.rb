module SallieMaeHelper
  def sallie_mae_button(payment,options={})
    options[:hide_form] = true
    options[:student_firstname] = false
    options[:student_lastname] = false
    options[:student_email] = false
    options[:account] = false
    options[:line_items] = false
    sallie_mae_form(payment,options)
  end
  
  def sallie_mae_form(payment,options={})
    options[:button_label] ||= "Make a Payment"
    options[:legend_text] ||= ""
    render 'sallie_mae/sallie_mae_form', payment: payment, options: options
  end
end