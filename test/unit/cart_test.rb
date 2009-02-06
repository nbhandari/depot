require 'test_helper'

class CartTest < ActiveSupport::TestCase
  
  test "add_product once" do
    cart = Cart.new
    assert_equal 0, cart.items.size
    
    product = products(:one)
    cart.add_product product
    
    assert_equal 1, cart.items.size
    assert_equal products(:one), cart.items[0].product
    assert_equal 1, cart.items[0].quantity
  end

  test "add_product same product twice" do
    cart = Cart.new
    assert_equal 0, cart.items.size
    
    product = products(:one)
    cart.add_product product
    cart.add_product product
    
    assert_equal 1, cart.items.size
    assert_equal products(:one), cart.items[0].product
    assert_equal 2, cart.items[0].quantity
  end

  test "add_product 2 different products" do
    cart = Cart.new
    assert_equal 0, cart.items.size
    
    product1 = products(:one)
    product2 = products(:two)
    
    cart.add_product product1
    cart.add_product product2
    
    assert_equal 2, cart.items.size
    assert_equal products(:one), cart.items[0].product
    assert_equal products(:two), cart.items[1].product
  end
  
  test "total_price empty cart" do
    cart = Cart.new
    assert_equal 0, cart.total_price
  end

  test "total_price 1 product" do
    cart = Cart.new
    assert_equal 0, cart.total_price
    
    product1 = products(:one)
    cart.add_product product1
    
    assert_equal product1.price, cart.total_price
  end
  
  test "total_price 2 products" do
    cart = Cart.new
    assert_equal 0, cart.total_price
    
    product1 = products(:one)
    product2 = products(:two)
    
    cart.add_product product1
    cart.add_product product2
    
    assert_equal (product1.price + product2.price), cart.total_price
  end

  test "total_price one product twice" do
    cart = Cart.new
    assert_equal 0, cart.total_price
    
    product1 = products(:one)
    
    cart.add_product product1
    cart.add_product product1
    
    assert_equal (2 * product1.price), cart.total_price
  end
  
end
