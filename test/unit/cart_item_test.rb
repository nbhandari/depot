require 'test_helper'

class CartItemTest < ActiveSupport::TestCase
  
  test "initialize" do
    product = products(:one)
    cart_item = CartItem.new product
    
    assert_equal products(:one), cart_item.product
    assert_equal 1, cart_item.quantity
  end

  test "increment_quantity" do
    product = products(:one)
    cart_item = CartItem.new product
    
    cart_item.increment_quantity
    
    assert_equal 2, cart_item.quantity
  end

  test "title" do
    product = products(:one)
    cart_item = CartItem.new product
    
    assert_equal product.title, cart_item.product.title
  end
  
  test "price one quantity" do
    product = products(:one)
    cart_item = CartItem.new product
    
    assert_equal product.price, cart_item.price
  end

  test "price two quantity" do
    product = products(:one)
    cart_item = CartItem.new product
    cart_item.increment_quantity
    
    assert_equal (2 * product.price), cart_item.price
  end
  
end
