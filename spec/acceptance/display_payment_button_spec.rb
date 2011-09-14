require 'acceptance/acceptance_helper'

feature 'Display payment button', %q{
  In order to make a payment
  As a student
  I want to see a button that takes me to the payment gateway
} do

  context "a single line item is provided" do
    scenario 'Payment button page is displayed', :js => true do
      visit payment_button_path
    
      within(:css, '#sallie_mae_gateway_form') do
        site_settings = { :school_id => 'SCHOOL_ID', :postback_url => 'ALT_OTPSSO_URL', :finish_url => 'FINISH_URL', :cancel_url => 'CANCEL_URL' }
        site_settings.each do |setting_name, form_element_name|
          xpath = %{//input[@type="hidden" and @name="#{form_element_name}"]} 
          find(:xpath, xpath).value.should == SALLIE_MAE_CONFIG[setting_name.to_s]
        end
        
        payment_elements = %w(ACCOUNT STUDENT_FIRSTNAME STUDENT_LASTNAME STUDENT_EMAIL_1 PMT_TYPE PMT_TYPE_DESC AMOUNT_PAID)  
        payment_elements.each do |form_element_name|
          xpath = %{//input[@type="hidden" and @name="#{form_element_name}"]}
          find(:xpath, xpath).value.should_not be_blank
        end
      
        page.should have_button('Make a Payment')
      end
      click_button 'Make a Payment'
      page.current_url.should == SALLIE_MAE_CONFIG['url']
    end
    
  end

end
