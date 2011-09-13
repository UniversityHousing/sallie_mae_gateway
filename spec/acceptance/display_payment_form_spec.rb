require 'acceptance/acceptance_helper'

feature 'Display payment form', %q{
  In order to make a payment
  As a student
  I want to see a read-only form that displays my information
  AND a button that takes me to the payment gateway
} do

  context "a single line item is provided" do
    scenario 'Payment form is displayed' do
      visit payment_form_path
    
      within(:css, '#sallie_mae_gateway_form') do
        site_settings = { :school_id => 'SCHOOL_ID', :postback_url => 'ALT_OTPSSO_URL', :finish_url => 'FINISH_URL', :cancel_url => 'CANCEL_URL' }
        site_settings.each do |setting_name, form_element_name|
          xpath = %{//input[@type="hidden" and @name="#{form_element_name}"]} 
          find(:xpath, xpath).value.should == SALLIE_MAE_CONFIG[setting_name.to_s]
        end
      
        payment_elements = %w(ACCOUNT STUDENT_FIRSTNAME STUDENT_LASTNAME STUDENT_EMAIL_1)  
        payment_elements.each do |form_element_name|
          xpath = %{//input[@type="text" and @name="#{form_element_name}" and @readonly="readonly"]}
          find(:xpath, xpath).value.should_not be_blank
        end
        
        page.should have_selector(:css, '#sallie_mae_line_items')    
        page.should have_button('Make a Payment')
      end
    end
  end

end
