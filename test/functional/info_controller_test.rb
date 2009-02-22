require 'test_helper'

class InfoControllerTest < ActionController::TestCase
  test "who bought one" do
    cart = Cart.new
    cart.add_product products(:one)
    
    order = orders(:one_info)
    order.add_line_items_from_cart(cart)
    
    get :who_bought, :id => products(:one).id
    
    assert_response :success
    
    assert_tag :tag => 'a', :attributes => {
      :href=> "mailto:#{orders(:one_info).email}"
    }, :content => orders(:one_info).name    
  end
  
  test "who bought one xml response" do
    cart = Cart.new
    cart.add_product products(:one)
    
    order = orders(:one_info)
    order.add_line_items_from_cart(cart)
    
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :who_bought, :id => products(:one).id
    
    assert_select "order", :count => 1
    assert_select "order" do
      assert_select "name", orders(:one_info).name
      assert_select "email", orders(:one_info).email
      assert_select "address", orders(:one_info).address
      assert_select "pay-type", orders(:one_info).pay_type
    end
    
  end

  test "who bought one json response" do
    cart = Cart.new
    cart.add_product products(:one)
    
    order = orders(:one_info)
    order.add_line_items_from_cart(cart)
    
    @request.env["HTTP_ACCEPT"] = "application/json"
    get :who_bought, :id => products(:one).id

    expected_name = "\"name\": \"#{orders(:one_info).name}\""
    expected_id = "\"id\": #{orders(:one_info).id}"
    expected_paytype = "\"pay_type\": \"#{orders(:one_info).pay_type}\""
    expected_address = "\"address\": \"#{orders(:one_info).address}\""
    expected_email = "\"email\": \"#{orders(:one_info).email}\""
    
    assert_match expected_name, @response.body
    assert_match expected_id, @response.body
    assert_match expected_paytype, @response.body
    assert_match expected_address, @response.body
    assert_match expected_email, @response.body
    
  end
  
end
