require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "name is required" do
    order = orders(:one)
    order.name = nil
    assert !order.save
  end
  
  test "address is required" do
    order = orders(:one)
    order.address = nil
    assert !order.save
  end
  
  test "email is required" do
    order = orders(:one)
    order.email = nil
    assert !order.save
  end

  test "payment-type is required" do
    order = orders(:one)
    order.pay_type = nil
    assert !order.save
  end

  test "add_line_items_from_cart" do
    cart = Cart.new
    
    cart.add_product products(:one)
    cart.add_product products(:one)
    cart.add_product products(:two)
    
    order = orders(:one)
    order.add_line_items_from_cart cart
    
    assert_equal    2, order.line_items.size
    
    assert_equal    products(:one), order.line_items[0].product
    assert_equal    products(:two), order.line_items[1].product
    
    assert_equal    2, order.line_items[0].quantity
    assert_equal    1, order.line_items[1].quantity

    assert_equal    2*products(:one).price, order.line_items[0].total_price
    assert_equal    products(:two).price, order.line_items[1].total_price
    
    assert order.save!
  end

end
