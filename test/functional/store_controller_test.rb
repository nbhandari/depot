require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)

    Product.find_products_for_sale.each do |product|
      assert_tag :tag => 'h3', :content => product.title
      assert_match /#{sprintf("%01.2f", product.price / 100.0)}/, @response.body
    end
  end
  
  test "add valid product to cart" do
    get :add_to_cart, :id => products(:one).id
    
    assert_response :success
    assert_tag :tag => 'div', :attributes => {
      :class => 'cart-title'
    }
    assert_tag :tag => 'td', :attributes => {
      :class => 'item-price'
    }
    assert_tag :tag => 'td', :attributes => {
      :class => 'total-cell'
    }
    assert_tag :tag => 'form', :attributes => {
      :action => '/store/empty_cart' ,
      :class => 'button-to'
    }
    
    assert_not_nil assigns(:cart)
  end
  
  test "add invalid product to cart" do
    get :add_to_cart, :id => 'junk'
    
    assert_response :redirect
    assert_redirected_to :action => :index
    assert_equal "Invalid Product", flash[:notice]
  end

  test "empty_cart" do
    get :empty_cart
    
    assert_response :redirect
    assert_redirected_to :action => :index
    assert_equal "Cart empty", flash[:notice]
    assert_nil assigns(:cart)
  end

end
