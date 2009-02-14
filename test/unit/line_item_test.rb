require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  
  test "line item from cart item" do
    prod = products(:one)
    cart_item = CartItem.new prod
    li = LineItem.from_cart_item cart_item
    
    assert_equal prod, li.product
    assert_equal 1, li.quantity
    assert_equal cart_item.price, li.total_price
  end
  
end
